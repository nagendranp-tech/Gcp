resource "google_compute_instance_group" "task_instance_group" {
  name = var.instance_group_name
  zone = var.zone

  instances = [
    var.vm_id
  ]

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_health_check" "task_health_check" {
  name = var.health_check_name

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "task_backend_service" {
  name          = var.backend_service_name
  protocol      = "HTTP"
  port_name     = "http"
  timeout_sec   = 30
  health_checks = [google_compute_health_check.task_health_check.id]

  backend {
    group = google_compute_instance_group.task_instance_group.id
  }
}

resource "google_compute_url_map" "task_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.task_backend_service.id
}

resource "google_compute_target_http_proxy" "task_http_proxy" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.task_url_map.id
}

resource "google_compute_global_address" "task_lb_ip" {
  name = var.lb_ip_name
}

resource "google_compute_global_forwarding_rule" "task_forwarding_rule" {
  name       = var.forwarding_rule_name
  target     = google_compute_target_http_proxy.task_http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.task_lb_ip.address
}
