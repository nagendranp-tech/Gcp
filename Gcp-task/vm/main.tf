resource "google_compute_instance" "task_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnet_id

    access_config {
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash

    apt-get update
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = ["http-server"]
}