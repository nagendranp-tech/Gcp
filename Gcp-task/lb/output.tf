output "load_balancer_ip" {
  value = google_compute_global_address.task_lb_ip.address
}

output "load_balancer_url" {
  value = "http://${google_compute_global_address.task_lb_ip.address}"
}

output "backend_service_id" {
  value = google_compute_backend_service.task_backend_service.id
}

output "instance_group_id" {
  value = google_compute_instance_group.task_instance_group.id
}