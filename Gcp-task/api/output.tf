
output "gateway_url" {
  description = "Deployed API Gateway URL"
  value       = google_api_gateway_gateway.gateway.default_hostname
}

output "gateway_id" {
  description = "API Gateway resource ID"
  value       = google_api_gateway_gateway.gateway.gateway_id
}

output "backend_service_account" {
  description = "Service account used for backend authentication"
  value       = google_service_account.backend_auth.email
}
