module "vpc" {
  source = "./vpc"

  vpc_name = var.vpc_name

  public_subnet_cidr1 = var.public_subnet_cidr1
  public_subnet_cidr2 = var.public_subnet_cidr2

  private_subnet_cidr1 = var.private_subnet_cidr1
  private_subnet_cidr2 = var.private_subnet_cidr2

  region = var.region

  router_name = var.router_name
  nat_name    = var.nat_name

  ssh_firewall_name      = var.ssh_firewall_name
  http_firewall_name     = var.http_firewall_name
  internal_firewall_name = var.internal_firewall_name
}

module "vm" {
  source = "./vm"

  vm_name        = var.vm_name
  machine_type   = var.machine_type
  zone           = var.zone
  image          = var.image
  boot_disk_size = var.boot_disk_size

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet1_id
}

module "lb" {
  source = "./lb"

  instance_group_name  = var.instance_group_name
  zone                 = var.zone
  vm_id                = module.vm.vm_id
  health_check_name    = var.health_check_name
  backend_service_name = var.backend_service_name
  url_map_name         = var.url_map_name
  http_proxy_name      = var.http_proxy_name
  lb_ip_name           = var.lb_ip_name
  forwarding_rule_name = var.forwarding_rule_name
}

module "storage" {
  source = "./storage"

  bucket_name     = var.bucket_name
  bucket_location = var.bucket_location
}

module "cdn" {
  source = "./cdn"

  bucket_name = module.storage.bucket_name

  backend_bucket_name  = var.backend_bucket_name
  url_map_name         = var.cdn_url_map_name
  http_proxy_name      = var.cdn_http_proxy_name
  cdn_ip_name          = var.cdn_ip_name
  forwarding_rule_name = var.cdn_forwarding_rule_name
}


module "gke" {
  source = "./gke"

  project_id   = var.project_id
  cluster_name = var.gke_cluster_name
  region       = var.region

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.private_subnet1_id

  node_service_account_id = var.gke_node_service_account_id
  node_pool_name          = var.gke_node_pool_name
  node_count              = var.gke_node_count
  machine_type            = var.gke_machine_type

  pods_range_name     = "gke-pods-range"
  services_range_name = "gke-services-range"
}


module "rds" {
  source = "./rds"

  project_id = var.project_id
  region     = var.region
  vpc_id     = module.vpc.vpc_id

  instance_name              = var.sql_instance_name
  database_name              = var.sql_database_name
  db_user                    = var.sql_db_user
  db_password                = var.sql_db_password
  machine_tier               = var.sql_machine_tier
  disk_size_gb               = var.sql_disk_size_gb
  private_service_range_name = var.sql_private_service_range_name
}


module "nlb" {
  source = "./nlb"

  nlb_name        = var.nlb_name
  app_label       = var.nlb_app_label
  nlb_port        = var.nlb_port
  app_target_port = var.nlb_app_target_port
}


module "api_gateway" {
  source = "./api"

  providers = {
    google-beta = google-beta
  }

  project_id     = var.project_id
  gateway_region = var.region

  backend_url = "http://${module.nlb.external_backend_ip}.nip.io"
}

module "pubsub" {
  source = "./pubsub"

  project_id        = var.project_id
  topic_name        = "task-topic"
  subscription_name = "task-subscription"
}

module "monitoring" {
  source = "./monitoring"

  project_id = var.project_id
}


module "logging" {
  source = "./logging"

  project_id      = var.project_id
  log_bucket_name = "task-central-logs"
  retention_days  = 30
}
