data "aws_iam_policy_document" "with_mfa" {
  statement {
    sid     = "WithMFA"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    principals {
      type        = "AWS"
      identifiers = ["${var.trusted_entity}"]
    }
  }
}

data "aws_iam_policy_document" "without_mfa" {
  statement {
    sid     = "WithoutMFA"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    # https://github.com/aws/aws-cli/issues/5942 
    # cannot implement since aws eks token command doesn't support external-id
    # condition {
    #   test     = "StringEquals"
    #   variable = "sts:ExternalId"

    #   values = [var.external_id]
    # }

    principals {
      type        = "AWS"
      identifiers = ["${var.trusted_entity}"]
    }
  }
}

# Create an IAM Role with an appropriate assume role policy.
# If External ID is present then without MFA, if absent then with MFA
resource "aws_iam_role" "default" {
  name                 = var.role_name
  assume_role_policy   = var.mfa_needed ? data.aws_iam_policy_document.with_mfa.json : data.aws_iam_policy_document.without_mfa.json
  max_session_duration = 21600
  tags = {
    terraform-managed = "true"
    account           = var.account
  }

}

# Attach the Policies provided to the IAM role created above
resource "aws_iam_role_policy_attachment" "default" {
  count      = length(var.policy_arn)
  policy_arn = var.policy_arn[count.index]
  role       = aws_iam_role.default.name
}
