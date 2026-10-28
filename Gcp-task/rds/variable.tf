
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "machine_tier" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "private_service_range_name" {
  type = string
}
