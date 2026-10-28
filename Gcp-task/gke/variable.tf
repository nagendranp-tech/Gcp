
variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "node_service_account_id" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "node_count" {
  type = number
}

variable "machine_type" {
  type = string
}

variable "pods_range_name" {
  type = string
}

variable "services_range_name" {
  type = string
}
