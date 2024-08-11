data "aws_caller_identity" "current" {}

# Create a Password Policy in the Identity Account as users will be created in this account only
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 10
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true

}

# Define an IAMAdmin Policy
data "aws_iam_policy_document" "iam_admin" {
  statement {
    sid       = "IAMAdmin"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["iam:*"]
  }
}

# Create an IAMAdmin Policy
resource "aws_iam_policy" "iam_admin" {
  name   = "IAMAdministrator"
  policy = data.aws_iam_policy_document.iam_admin.json

}

# Create an Admin Role with Administrator Access Policy with MFA
module "assume_iam_admin_role_with_mfa" {
  source = "../../modules/assumerolepolicytrust"

  role_name      = "AssumeRoleIAMAdminWithMFA"
  trusted_entity = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
  policy_arn     = [aws_iam_policy.iam_admin.arn]
  account        = "identity"

}

# Define a Self Manage Policy
data "aws_iam_policy_document" "self_manage" {
  statement {
    sid       = "AllowViewAccountInfo"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListVirtualMFADevices",
    ]
  }

  statement {
    sid       = "AllowManageOwnPasswords"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}"]

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]
  }

  statement {
    sid       = "AllowManageOwnVirtualMFADevice"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/*"]

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]
  }

  statement {
    sid       = "AllowManageOwnUserMFA"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/$${aws:username}"]

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]
  }

  # Deny all actions EXCEPT the given below if user has not configured MFA
  statement {
    sid       = "DenyAllExceptListedIfNoMFA"
    effect    = "Deny"
    resources = ["*"]

    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
      "iam:ChangePassword",
      "iam:GetUser",
    ]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}

# Create an Self Manage Policy
resource "aws_iam_policy" "self_manage" {
  name   = "SelfManage"
  policy = data.aws_iam_policy_document.self_manage.json

}

# Create an IAM Administrator Group
resource "aws_iam_group" "self_manage" {
  name = "SelfManage"

}

# Attach the IAM Administrator Policy with IAMAdministrator Group
resource "aws_iam_group_policy_attachment" "self_manage" {
  group      = aws_iam_group.self_manage.name
  policy_arn = aws_iam_policy.self_manage.arn

}