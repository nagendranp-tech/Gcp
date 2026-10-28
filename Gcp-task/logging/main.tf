
resource "google_project_service" "logging_api" {
  project            = var.project_id
  service            = "logging.googleapis.com"
  disable_on_destroy = false
}

resource "google_logging_project_bucket_config" "central_logs" {
  project        = var.project_id
  location       = "global"
  bucket_id      = var.log_bucket_name
  description    = "Centralized VPC Flow Logs and Cloud SQL logs"
  retention_days = var.retention_days

  depends_on = [
    google_project_service.logging_api
  ]
}

resource "google_logging_project_sink" "central_logs_sink" {
  project                = var.project_id
  name                   = "task-central-logs-sink"
  description            = "Routes VPC Flow Logs and Cloud SQL logs"
  destination            = "logging.googleapis.com/${google_logging_project_bucket_config.central_logs.id}"
  unique_writer_identity = false

  filter = <<-EOT
    (
      log_id("compute.googleapis.com/vpc_flows")
      OR resource.type = "gce_subnetwork"
    )
    OR resource.type = "cloudsql_database"
  EOT

  depends_on = [
    google_logging_project_bucket_config.central_logs
  ]
}
