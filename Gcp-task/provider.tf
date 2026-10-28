
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "8.5.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "8.5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}
