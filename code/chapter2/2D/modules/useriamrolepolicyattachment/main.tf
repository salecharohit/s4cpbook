data "aws_iam_policy_document" "default" {
  statement {
    sid       = ""
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.roles
  }
}

# Create an IAM Policy that allows Assuming the IAM roles for cross-account authentication
resource "aws_iam_policy" "default" {
  name        = "AssumeRoles${var.user_name}"
  description = "Allow IAM User to Assume the IAM Roles"
  policy      = data.aws_iam_policy_document.default.json
  tags = {
    terraform-managed = "true"
  }
}

# Attach the Policy to a particular User
resource "aws_iam_user_policy_attachment" "default" {
  user       = var.user_name
  policy_arn = aws_iam_policy.default.arn
}
