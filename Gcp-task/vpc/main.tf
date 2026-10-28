resource "google_compute_network" "task_vpc" {
  name                    = "task-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet1" {
  name          = "public-subnet-1"
  ip_cidr_range = var.public_subnet_cidr1
  region        = var.region
  network       = google_compute_network.task_vpc.id
}

resource "google_compute_subnetwork" "public_subnet2" {
  name          = "public-subnet-2"
  ip_cidr_range = var.public_subnet_cidr2
  region        = var.region
  network       = google_compute_network.task_vpc.id


  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}


resource "google_compute_subnetwork" "private_subnet1" {
  name          = "private-subnet-1"
  ip_cidr_range = var.private_subnet_cidr1
  region        = var.region
  network       = google_compute_network.task_vpc.id

  secondary_ip_range {
    range_name    = "gke-pods-range"
    ip_cidr_range = "10.10.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-services-range"
    ip_cidr_range = "10.20.0.0/20"
  }
}


resource "google_compute_subnetwork" "private_subnet2" {
  name          = "private-subnet-2"
  ip_cidr_range = var.private_subnet_cidr2
  region        = var.region
  network       = google_compute_network.task_vpc.id


  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

}

resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region
  network = google_compute_network.task_vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet2.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name    = var.ssh_firewall_name
  network = google_compute_network.task_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name    = var.http_firewall_name
  network = google_compute_network.task_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = var.internal_firewall_name
  network = google_compute_network.task_vpc.id

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    var.public_subnet_cidr1,
    var.public_subnet_cidr2,
    var.private_subnet_cidr1,
    var.private_subnet_cidr2
  ]
}

