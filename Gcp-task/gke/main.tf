resource "google_project_service" "container_api" {
  project            = var.project_id
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "gke_nodes" {
  account_id   = var.node_service_account_id
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_member" "node_service_account" {
  project = var.project_id
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "node_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "node_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "node_monitoring_viewer" {
  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_project_iam_member" "node_artifact_registry" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_container_cluster" "task_gke" {
  name     = var.cluster_name
  location = var.region

  node_locations = ["asia-south1-a"]

  network    = var.vpc_id
  subnetwork = var.subnet_id

  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    disk_type    = "pd-standard"
    disk_size_gb = 30
  }

  lifecycle {
    ignore_changes = [node_config]
  }


  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS",
      "APISERVER",
      "CONTROLLER_MANAGER",
      "SCHEDULER"
    ]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  release_channel {
    channel = "REGULAR"
  }

  depends_on = [
    google_project_service.container_api
  ]
}

resource "google_container_node_pool" "worker_nodes" {
  name     = var.node_pool_name
  location = var.region
  cluster  = google_container_cluster.task_gke.name

  node_locations = ["asia-south1-a"]

  node_count = var.node_count

  node_config {
    machine_type    = var.machine_type
    service_account = google_service_account.gke_nodes.email

    disk_type    = "pd-standard"
    disk_size_gb = 30

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = "task"
      role        = "worker"
    }

    tags = ["gke-worker"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [
    google_project_iam_member.node_service_account,
    google_project_iam_member.node_logging,
    google_project_iam_member.node_monitoring,
    google_project_iam_member.node_monitoring_viewer,
    google_project_iam_member.node_artifact_registry
  ]
}