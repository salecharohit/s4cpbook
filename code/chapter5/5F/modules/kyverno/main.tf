# Fetch account ID of the current organisation
data "aws_caller_identity" "current" {}
# Fetch Current Region
data "aws_region" "current" {}

locals {
  allowed_ecr = "${data.aws_caller_identity.current.id}.dkr.ecr.${data.aws_region.current.id}.amazonaws.com/*"
}

# Create Kyverno Namespace
resource "kubernetes_namespace_v1" "kyverno" {
  metadata {
    annotations = {
      name = "kyverno"
    }
    name = "kyverno"
  }
}

# Install Kyverno.
resource "helm_release" "kyverno" {
  name            = "kyverno"
  chart           = "kyverno"
  repository      = "https://kyverno.github.io/kyverno/"
  namespace       = kubernetes_namespace_v1.kyverno.metadata.0.name
  cleanup_on_fail = true
  version         = var.kyverno_helm_version

  dynamic "set" {
    for_each = {
      # For Dev replicacount is 1 for Prod environments with multi-node clusters it should be 3        
      "replicaCount" = 1
    }
    content {
      name  = set.key
      value = set.value
    }
  }

}

# Kyverno Policy to resrtict images from ECR
resource "kubectl_manifest" "kyverno_image_policy" {
  yaml_body = <<YAML
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: restrict-images-to-ecr
  annotations:
    policies.kyverno.io/title: Restrict Images to AWS ECR
    policies.kyverno.io/category: Pod Security, EKS Best Practices
    policies.kyverno.io/severity: high
    policies.kyverno.io/minversion: 1.6.0
    policies.kyverno.io/subject: Pod
    policies.kyverno.io/description: >-
      All pods executed by (except the system ones) must be deployed through the ECR registry created in AWS       
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: check-image-registry
    match:
      all:
      - resources:
          kinds:
          - Pod
          namespaces:
          - "${var.namespace}"
    validate:
      message: "Pods can only use images from the AWS ECR registry ${local.allowed_ecr}"
      pattern:
        spec:
          containers:
          - image: "${local.allowed_ecr}"
YAML

  depends_on = [
    helm_release.kyverno
  ]

}

# Kyverno Policy to enforce baseline security
resource "kubectl_manifest" "kyverno_pod_security_standards" {
  yaml_body = <<YAML
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: podsecurity-subrule-baseline
  annotations:
    policies.kyverno.io/title: Baseline Pod Security Standards
    policies.kyverno.io/category: Pod Security, EKS Best Practices
    policies.kyverno.io/severity: high
    kyverno.io/kyverno-version: 1.8.0
    policies.kyverno.io/minversion: 1.8.0
    kyverno.io/kubernetes-version: "1.24"
    policies.kyverno.io/subject: Pod
    policies.kyverno.io/description: >-
      The baseline profile of the Pod Security Standards is a collection of the
      most basic and important steps that can be taken to secure Pods. Beginning
      with Kyverno 1.8, an entire profile may be assigned to the cluster through a
      single rule. This policy configures the baseline profile through the latest
      version of the Pod Security Standards cluster wide.    
spec:
  validationFailureAction: Enforce
  background: true
  rules:
  - name: baseline
    match:
      all:
      - resources:
          kinds:
          - Pod
          namespaces:
          - "${var.namespace}"
    validate:
      podSecurity:
        level: baseline
        version: latest
YAML

  depends_on = [
    helm_release.kyverno
  ]

}