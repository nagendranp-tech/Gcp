
output "topic_id" {
  description = "Pub/Sub topic ID"
  value       = google_pubsub_topic.topic.id
}

output "subscription_id" {
  description = "Pub/Sub subscription ID"
  value       = google_pubsub_subscription.subscription.id
}

output "topic_name" {
  description = "Pub/Sub topic name"
  value       = google_pubsub_topic.topic.name
}

output "subscription_name" {
  description = "Pub/Sub subscription name"
  value       = google_pubsub_subscription.subscription.name
}
    