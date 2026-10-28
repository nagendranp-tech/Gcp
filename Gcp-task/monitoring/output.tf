output "high_cpu_alert_policy_name" {
  description = "Name of the high CPU alert policy"
  value       = google_monitoring_alert_policy.high_cpu.name
}

output "high_cpu_alert_display_name" {
  description = "Display name of the high CPU alert policy"
  value       = google_monitoring_alert_policy.high_cpu.display_name
}