
output "log_bucket_id" {
  description = "ID of the centralized Cloud Logging bucket"
  value       = google_logging_project_bucket_config.central_logs.id
}

output "log_sink_name" {
  description = "Name of the centralized logging sink"
  value       = google_logging_project_sink.central_logs_sink.name
}

output "log_sink_writer_identity" {
  description = "Service identity used by the logging sink"
  value       = google_logging_project_sink.central_logs_sink.writer_identity
}
