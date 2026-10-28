output "vm_id" {
  value = google_compute_instance.task_vm.id
}

output "vm_name" {
  value = google_compute_instance.task_vm.name
}

output "vm_public_ip" {
  value = google_compute_instance.task_vm.network_interface[0].access_config[0].nat_ip
}

output "vm_private_ip" {
  value = google_compute_instance.task_vm.network_interface[0].network_ip
}