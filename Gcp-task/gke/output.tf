
output "cluster_name" {
  value = google_container_cluster.task_gke.name
}

output "cluster_endpoint" {
  value     = google_container_cluster.task_gke.endpoint
  sensitive = true
}

output "cluster_location" {
  value = google_container_cluster.task_gke.location
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.task_gke.master_auth[0].cluster_ca_certificate
  sensitive = true
}

output "node_pool_name" {
  value = google_container_node_pool.worker_nodes.name
}

output "node_service_account" {
  value = google_service_account.gke_nodes.email
}
