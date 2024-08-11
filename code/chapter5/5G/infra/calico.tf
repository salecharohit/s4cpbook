# Install Calico CNI and replace with AWS
resource "helm_release" "calico" {
  name             = "calico"
  chart            = "tigera-operator"
  repository       = "https://docs.projectcalico.org/charts"
  namespace        = "tigera-operator"
  cleanup_on_fail  = true
  version          = "3.24.1"
  create_namespace = true

  dynamic "set" {
    for_each = {
      "installation.kubernetesProvider" = "EKS"
    }
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [module.eks, module.networking]

}

# Deny all comms by default
resource "kubernetes_network_policy" "default_deny" {
  metadata {
    name      = "default-deny"
    namespace = kubernetes_namespace_v1.app.metadata.0.name
  }

  spec {
    pod_selector {
      match_labels = {}
    }

    policy_types = ["Ingress", "Egress"]
  }

  depends_on = [resource.helm_release.calico]

}