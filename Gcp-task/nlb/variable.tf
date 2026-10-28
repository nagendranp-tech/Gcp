
variable "nlb_name" {
  description = "Name of the internal Network Load Balancer"
  type        = string
  default     = "task-internal-nlb"
}

variable "app_label" {
  description = "Label used to select application Pods"
  type        = string
  default     = "task-app"
}

variable "nlb_port" {
  description = "Port exposed by the internal load balancer"
  type        = number
  default     = 80
}

variable "app_target_port" {
  description = "Port on which application Pods receive traffic"
  type        = number
  default     = 80
}
