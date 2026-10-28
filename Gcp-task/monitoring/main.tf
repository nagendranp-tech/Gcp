
resource "google_project_service" "monitoring" {
  project            = var.project_id
  service            = "monitoring.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "logging" {
  project            = var.project_id
  service            = "logging.googleapis.com"
  disable_on_destroy = false
}

resource "google_monitoring_alert_policy" "high_cpu" {
  project      = var.project_id
  display_name = "task-vm-high-cpu-alert"
  combiner     = "OR"

  conditions {
    display_name = "VM CPU utilization above 80%"

    condition_threshold {
      filter = join(" AND ", [
        "resource.type = \"gce_instance\"",
        "metric.type = \"compute.googleapis.com/instance/cpu/utilization\""
      ])

      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }

      trigger {
        count = 1
      }
    }
  }

  documentation {
    content = "Investigate Compute Engine VM CPU utilization when it remains above 80% for five minutes."
  }

  depends_on = [
    google_project_service.monitoring,
    google_project_service.logging
  ]
}
