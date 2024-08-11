# Create an Admin Role with Administrator Access Policy with MFA
module "assume_admin_role_with_mfa" {
  source = "../../modules/assumerolepolicytrust"

  role_name      = "AssumeRoleAdminWithMFA${var.account}"
  trusted_entity = "arn:aws:iam::${var.identity_account_id}:root"
  policy_arn     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  account        = var.account

}

# Create an IAM Role and attach the EKSRead Only Policy for Developers Group
module "assume_readonly_role" {
  source = "../../modules/assumerolepolicytrust"

  role_name      = "AssumeReadOnlyrWithMFA${var.account}"
  trusted_entity = "arn:aws:iam::${var.identity_account_id}:root"
  policy_arn     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  account        = var.account

}

# Create a Hosted Zone with provided domain name
# Export the Nameservers to update the DNS Records.
resource "aws_route53_zone" "default" {
  name = var.domain

  tags = {
    Account           = var.account
    terraform-managed = "true"
  }
}

resource "aws_ecr_repository" "default" {
  name                 = "s4cpecr"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    env               = "${var.account}"
    terraform-managed = "true"
  }
}

module "github_oidc_ecr_role" {
  source  = "github.com/terraform-module/terraform-aws-github-oidc-provider.git?ref=v2.2.0"

  create_oidc_provider = true
  create_oidc_role     = true
  role_name            = "OIDCECRAdmin${var.account}"
  repositories              = ["${var.github_account_repo}"]
  oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"]
}
