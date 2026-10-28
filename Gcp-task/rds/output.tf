
output "instance_name" {
  description = "Cloud SQL instance name"
  value       = google_sql_database_instance.mysql.name
}

output "private_ip_address" {
  description = "Private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.mysql.private_ip_address
}

output "database_name" {
  description = "Application database name"
  value       = google_sql_database.application_db.name
}

output "database_user" {
  description = "Application database username"
  value       = google_sql_user.application_user.name
}
