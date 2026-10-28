resource "google_compute_backend_bucket" "task_backend_bucket" {
  name        = var.backend_bucket_name
  bucket_name = var.bucket_name
  enable_cdn  = true
}

resource "google_compute_url_map" "task_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_bucket.task_backend_bucket.id
}

resource "google_compute_target_http_proxy" "task_http_proxy" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.task_url_map.id
}

resource "google_compute_global_address" "task_cdn_ip" {
  name = var.cdn_ip_name
}

resource "google_compute_global_forwarding_rule" "task_forwarding_rule" {
  name       = var.forwarding_rule_name
  target     = google_compute_target_http_proxy.task_http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.task_cdn_ip.address
}