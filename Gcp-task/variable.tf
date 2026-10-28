variable "vpc_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "public_subnet_cidr1" {
  type = string
}

variable "public_subnet_cidr2" {
  type = string
}

variable "private_subnet_cidr1" {
  type = string
}

variable "private_subnet_cidr2" {
  type = string
}

variable "region" {
  type = string
}

variable "router_name" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "ssh_firewall_name" {
  type = string
}

variable "http_firewall_name" {
  type = string
}

variable "internal_firewall_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = string
}

variable "image" {
  type = string
}

variable "boot_disk_size" {
  type = number
}

variable "instance_group_name" {
  type = string
}

variable "health_check_name" {
  type = string
}

variable "backend_service_name" {
  type = string
}

variable "url_map_name" {
  type = string
}

variable "http_proxy_name" {
  type = string
}

variable "lb_ip_name" {
  type = string
}

variable "forwarding_rule_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_location" {
  type = string
}

variable "backend_bucket_name" {
  type = string
}

variable "cdn_url_map_name" {
  type = string
}

variable "cdn_http_proxy_name" {
  type = string
}

variable "cdn_ip_name" {
  type = string
}

variable "cdn_forwarding_rule_name" {
  type = string
}


variable "gke_cluster_name" {
  type = string
}

variable "gke_node_service_account_id" {
  type = string
}

variable "gke_node_pool_name" {
  type = string
}

variable "gke_node_count" {
  type = number
}

variable "gke_machine_type" {
  type = string
}


variable "sql_instance_name" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "sql_db_user" {
  type = string
}

variable "sql_db_password" {
  type      = string
  sensitive = true
}

variable "sql_machine_tier" {
  type = string
}

variable "sql_disk_size_gb" {
  type = number
}

variable "sql_private_service_range_name" {
  type = string
}


variable "nlb_name" {
  type    = string
  default = "task-internal-nlb"
}

variable "nlb_app_label" {
  type    = string
  default = "task-app"
}

variable "nlb_port" {
  type    = number
  default = 80
}

variable "nlb_app_target_port" {
  type    = number
  default = 80
}
