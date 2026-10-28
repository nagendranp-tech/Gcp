output "cdn_ip" {
  value = google_compute_global_address.task_cdn_ip.address
}

output "cdn_url" {
  value = "http://${google_compute_global_address.task_cdn_ip.address}"
}

output "backend_bucket_id" {
  value = google_compute_backend_bucket.task_backend_bucket.id
}