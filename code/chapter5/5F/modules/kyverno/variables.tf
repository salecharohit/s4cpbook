variable "namespace" {
  description = "Namespace on which specific policies need to be applied"
  type        = string
}

variable "kyverno_helm_version" {
  description = "Version of Kyverno Helm Chart"
  type        = string
}