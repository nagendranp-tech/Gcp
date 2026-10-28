
resource "google_project_service" "pubsub" {
  project            = var.project_id
  service            = "pubsub.googleapis.com"
  disable_on_destroy = false
}

resource "google_pubsub_topic" "topic" {
  project = var.project_id
  name    = var.topic_name

  depends_on = [
    google_project_service.pubsub
  ]
}

resource "google_pubsub_subscription" "subscription" {
  project = var.project_id
  name    = var.subscription_name
  topic   = google_pubsub_topic.topic.id

  ack_deadline_seconds = 20
}
