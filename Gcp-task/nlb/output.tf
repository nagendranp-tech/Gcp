
output "nlb_name" {
  description = "Name of the internal NLB Service"
  value       = kubernetes_service_v1.internal_nlb.metadata[0].name
}

output "nlb_internal_ip" {
  description = "Internal IP assigned to the NLB"
  value = try(
    kubernetes_service_v1.internal_nlb.status[0].load_balancer[0].ingress[0].ip,
    null
  )
}

output "external_backend_ip" {
  description = "Public IP of the GKE HTTP backend"
  value = try(
    kubernetes_service_v1.external_backend.status[0].load_balancer[0].ingress[0].ip,
    null
  )
}
