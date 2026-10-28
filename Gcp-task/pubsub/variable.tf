
variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "topic_name" {
  description = "Pub/Sub topic name"
  type        = string
  default     = "task-topic"
}

variable "subscription_name" {
  description = "Pub/Sub subscription name"
  type        = string
  default     = "task-subscription"
}
