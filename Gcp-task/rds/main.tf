
resource "google_project_service" "service_networking_api" {
  project            = var.project_id
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "sql_admin_api" {
  project            = var.project_id
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_global_address" "private_service_range" {
  name          = var.private_service_range_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id

  depends_on = [
    google_project_service.service_networking_api
  ]
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network = var.vpc_id
  service = "servicenetworking.googleapis.com"

  reserved_peering_ranges = [
    google_compute_global_address.private_service_range.name
  ]

  deletion_policy = "ABANDON"

  depends_on = [
    google_project_service.service_networking_api
  ]
}

resource "google_sql_database_instance" "mysql" {
  name             = var.instance_name
  region           = var.region
  database_version = "MYSQL_8_4"

  deletion_protection = false

  settings {
    edition           = "ENTERPRISE"
    tier              = var.machine_tier
    disk_type         = "PD_HDD"
    disk_size         = var.disk_size_gb
    disk_autoresize   = true
    availability_type = "ZONAL"

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

    database_flags {
      name  = "log_output"
      value = "FILE"
    }

    database_flags {
      name  = "long_query_time"
      value = "2"
    }

    backup_configuration {
      enabled                        = true
      start_time                     = "03:00"
      transaction_log_retention_days = 7

      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }

  depends_on = [
    google_project_service.sql_admin_api,
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "google_sql_database" "application_db" {
  name     = var.database_name
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "application_user" {
  name     = var.db_user
  instance = google_sql_database_instance.mysql.name
  password = var.db_password
}
