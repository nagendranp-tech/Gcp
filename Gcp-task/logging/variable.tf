
variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "log_bucket_name" {
  description = "Name of the centralized Cloud Logging bucket"
  type        = string
  default     = "task-central-logs"
}

variable "retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 30
}
