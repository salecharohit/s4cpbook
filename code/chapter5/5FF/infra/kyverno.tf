# Module install kyverno and applies image restriction policy
module "kyverno" {
  source = "../modules/kyverno"

  namespace = kubernetes_namespace_v1.app.metadata.0.name
  #https://github.com/kyverno/kyverno/blob/main/charts/kyverno/Chart.yaml  
  kyverno_helm_version = "3.0.0"

  depends_on = [module.eks, module.networking]
}

resource "kubernetes_deployment_v1" "kyverno_test" {
  metadata {
    name      = "kyverno-test"
    namespace = kubernetes_namespace_v1.app.metadata.0.name
    labels = {
      test = "kyverno"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "kyverno"
      }
    }

    template {
      metadata {
        labels = {
          test = "kyverno"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "kyverno-test"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}