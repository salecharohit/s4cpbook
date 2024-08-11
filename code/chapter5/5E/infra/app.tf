################# Create Namespace ################################

resource "kubernetes_namespace_v1" "app" {
  metadata {
    annotations = {
      name = var.org_name
    }
    name = var.org_name
  }
  depends_on = [module.eks]
}

################ Install CSI Driver ################################

# https://secrets-store-csi-driver.sigs.k8s.io/getting-started/installation.html
resource "helm_release" "csi_secrets" {
  name            = "csi-secrets-store"
  chart           = "secrets-store-csi-driver"
  version         = "1.3.0"
  repository      = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  namespace       = "kube-system"
  cleanup_on_fail = true

  dynamic "set" {
    for_each = {
      "syncSecret.enabled"   = true
      "enableSecretRotation" = false
    }
    content {
      name  = set.key
      value = set.value
    }
  }
  depends_on = [module.eks]
}

# Install the CSI Secrets Driver for AWS using the helm chart.
# https://aws.github.io/secrets-store-csi-driver-provider-aws/
resource "helm_release" "aws_csi_secrets" {
  name            = "aws-secrets-manager"
  chart           = "secrets-store-csi-driver-provider-aws"
  namespace       = "kube-system"
  repository      = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  cleanup_on_fail = true

  depends_on = [
    helm_release.csi_secrets
  ]

}

################# Create Service Accounts ###########################

data "aws_iam_policy_document" "secrets_policy" {
  statement {
    sid    = "SecretsManagerReadOnly"
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    ]

    resources = [
      "${module.awssm-db-password.arn}",
    ]
  }
}

resource "aws_iam_policy" "secrets_policy" {
  name   = "secrets_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.secrets_policy.json
}

module "irsa_aws_secrets" {
  source = "../modules/irsa"

  oidc_url         = module.eks.cluster_oidc_issuer_url
  oidc_arn         = module.eks.oidc_provider_arn
  k8s_sa_namespace = kubernetes_namespace_v1.app.metadata.0.name
  k8s_irsa_name    = "irsa-aws-secrets"
  policy_arn       = resource.aws_iam_policy.secrets_policy.arn

  depends_on = [module.eks]
}

################# Read Secrets #######################################

resource "kubectl_manifest" "secrets" {
  yaml_body = <<YAML
apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
kind: SecretProviderClass
metadata:
  name: aws-secret-application
  namespace: ${kubernetes_namespace_v1.app.metadata.0.name}
spec:
  provider: aws
  secretObjects:
    - secretName: db-password-secret
      type: Opaque
      data:
        - objectName: ${var.db_pwd_parameter_name}
          key: db_password
  parameters:
    objects: |
      - objectName: ${var.db_pwd_parameter_name}
        objectType: "secretsmanager"
YAML

  depends_on = [module.pgsql,
    helm_release.aws_csi_secrets
  ]

}

################# Deploy Application #################################

resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = var.org_name
    namespace = kubernetes_namespace_v1.app.metadata.0.name
    labels = {
      app = var.org_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.org_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.org_name
        }
      }

      spec {
        container {
          image = var.app_docker_img
          name  = var.org_name
          env {
            name  = "DB_PORT"
            value = "5432"
          }
          env {
            name  = "DB_HOST"
            value = module.pgsql.db_instance_address
          }
          env {
            name  = "DB_NAME"
            value = var.db_name
          }
          env {
            name  = "DB_USERNAME"
            value = var.db_user_name
          }
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = "db-password-secret"
                key  = "db_password"
              }
            }
          }

          volume_mount {
            name       = "db-password-vol"
            mount_path = "/mnt/secrets-store"
            read_only  = true
          }

          port {
            container_port = "8080"
            protocol       = "TCP"
          }

          resources {
            limits = {
              cpu    = "1"
              memory = "300Mi"
            }
            requests = {
              cpu    = "0.25"
              memory = "200Mi"
            }
          }

          security_context {
            allow_privilege_escalation = false
            capabilities {
              drop = [
                "SETUID",
                "SETGID"
              ]
            }
          }
        }
        volume {
          name = "db-password-vol"
          csi {
            driver    = "secrets-store.csi.k8s.io"
            read_only = true
            volume_attributes = {
              "secretProviderClass" = "aws-secret-application"
            }
          }
        }

        service_account_name = module.irsa_aws_secrets.sa_name
      }
    }
  }

  depends_on = [module.pgsql,
    helm_release.aws_csi_secrets,
    kubectl_manifest.secrets
  ]
}

resource "kubernetes_service" "app" {
  metadata {
    name      = var.org_name
    namespace = kubernetes_namespace_v1.app.metadata.0.name
  }
  spec {
    port {
      port        = 8080
      target_port = 8080
    }
    selector = {
      app = var.org_name
    }
    type = "NodePort"
  }
  depends_on = [kubernetes_deployment_v1.app]
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [kubernetes_service.app]

  create_duration = "90s"
}

resource "kubernetes_ingress_v1" "app" {
  wait_for_load_balancer = true
  metadata {
    name      = var.org_name
    namespace = kubernetes_namespace_v1.app.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class"               = "alb"
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip"
      "alb.ingress.kubernetes.io/certificate-arn" = module.acm.acm_certificate_arn
      "alb.ingress.kubernetes.io/listen-ports"    = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
    }
  }
  spec {
    rule {
      host = local.url
      http {
        path {
          backend {
            service {
              name = var.org_name
              port {
                number = 8080
              }
            }
          }
          path = "/*"
        }
      }
    }
  }
  depends_on = [module.alb_ingress, time_sleep.wait_90_seconds]
}

output "hostname" {
  value = kubernetes_ingress_v1.app.status.0.load_balancer.0.ingress.0.hostname
}