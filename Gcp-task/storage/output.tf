output "bucket_name" {
  value = google_storage_bucket.task_bucket.name
}

output "bucket_id" {
  value = google_storage_bucket.task_bucket.id
}