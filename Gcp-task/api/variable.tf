
variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "backend_url" {
  description = "Reachable HTTP(S) backend URL"
  type        = string
}

variable "gateway_region" {
  description = "Region where API Gateway is deployed"
  type        = string
  default     = "asia-south1"
}
