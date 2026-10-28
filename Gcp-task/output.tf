output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.vpc_name
}

output "public_subnet1_id" {
  value = module.vpc.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.vpc.public_subnet2_id
}

output "private_subnet1_id" {
  value = module.vpc.private_subnet1_id
}

output "private_subnet2_id" {
  value = module.vpc.private_subnet2_id
}

output "vm_id" {
  value = module.vm.vm_id
}

output "vm_name" {
  value = module.vm.vm_name
}

output "vm_public_ip" {
  value = module.vm.vm_public_ip
}

output "vm_private_ip" {
  value = module.vm.vm_private_ip
}

output "load_balancer_ip" {
  value = module.lb.load_balancer_ip
}

output "load_balancer_url" {
  value = module.lb.load_balancer_url
}


output "gke_cluster_name" {
  value = module.gke.cluster_name
}

output "gke_cluster_location" {
  value = module.gke.cluster_location
}

output "gke_cluster_endpoint" {
  value     = module.gke.cluster_endpoint
  sensitive = true
}

output "gke_node_pool_name" {
  value = module.gke.node_pool_name
}

output "gke_node_service_account" {
  value = module.gke.node_service_account
}

output "api_gateway_url" {
  description = "Public HTTPS URL of the API Gateway"
  value       = "https://${module.api_gateway.gateway_url}"
}