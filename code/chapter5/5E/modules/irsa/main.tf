# Create an IAM Policy document for AssumingRolewith Web Identity and federated using OIDC
data "aws_iam_policy_document" "default" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.k8s_sa_namespace}:${var.k8s_irsa_name}"]
    }

    principals {
      identifiers = [var.oidc_arn]
      type        = "Federated"
    }
  }
}

# Create an IAM Role
resource "aws_iam_role" "default" {
  name               = var.k8s_irsa_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.default.json
}

# Atach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = var.policy_arn
}

# Create an K8s Service Account and Attach IAM Role to this SA
resource "kubernetes_service_account" "default" {
  metadata {
    name      = resource.aws_iam_role.default.name
    namespace = var.k8s_sa_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.default.arn
    }
  }
  automount_service_account_token = true
}