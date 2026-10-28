resource "kubernetes_deployment_v1" "app" {
  metadata {
    name = "task-app"

    labels = {
      app = var.app_label
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.app_label
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_label
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:stable"

          port {
            container_port = 80
          }

          command = ["/bin/sh", "-c"]

          args = [
            "echo 'OK' > /usr/share/nginx/html/health && exec nginx -g 'daemon off;'"
          ]
        }
      }
    }
  }
}
resource "kubernetes_service_v1" "internal_nlb" {
  metadata {
    name = var.nlb_name

    annotations = {
      "networking.gke.io/load-balancer-type" = "Internal"
    }

    labels = {
      app = var.app_label
    }
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = var.app_label
    }

    port {
      name        = "http"
      port        = var.nlb_port
      target_port = var.app_target_port
      protocol    = "TCP"
    }
  }

  depends_on = [
    kubernetes_deployment_v1.app
  ]
}

resource "kubernetes_service_v1" "external_backend" {
  metadata {
    name = "task-gke-external-backend"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = var.app_label
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
  }

  depends_on = [
    kubernetes_deployment_v1.app
  ]
}
