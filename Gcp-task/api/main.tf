

terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

resource "google_project_service" "api_gateway" {
  for_each = toset([
    "apigateway.googleapis.com",
    "servicemanagement.googleapis.com",
    "servicecontrol.googleapis.com",
  ])

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_service_account" "backend_auth" {
  project      = var.project_id
  account_id   = "task-api-gateway"
  display_name = "API Gateway backend authentication"

  depends_on = [
    google_project_service.api_gateway,
  ]
}

resource "google_api_gateway_api" "api" {
  provider = google-beta

  project      = var.project_id
  api_id       = "task-gke-api"
  display_name = "Task GKE API"

  depends_on = [
    google_project_service.api_gateway,
  ]
}

resource "google_api_gateway_api_config" "config" {
  provider = google-beta

  project       = var.project_id
  api           = google_api_gateway_api.api.api_id
  api_config_id = "task-gke-config-v1"
  display_name  = "Task GKE API configuration"

  gateway_config {
    backend_config {
      google_service_account = google_service_account.backend_auth.email
    }
  }

  openapi_documents {
    document {
      path = "openapi.yaml"

      contents = base64encode(
        templatefile("${path.module}/openapi.yaml", {
          backend_url = var.backend_url
        })
      )
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    google_project_service.api_gateway,
  ]
}

resource "google_api_gateway_gateway" "gateway" {
  provider = google-beta

  project      = var.project_id
  region       = "asia-northeast1"
  gateway_id   = "task-gke-gateway"
  display_name = "Task GKE API Gateway"
  api_config   = google_api_gateway_api_config.config.id
}
