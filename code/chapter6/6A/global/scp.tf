data "aws_iam_policy_document" "deny_user_creation_scp" {
  statement {
    sid       = "DenyCreatingIAMUsers"
    effect    = "Deny"
    resources = ["*"]

    actions = [
      "iam:CreateUser",
      "iam:CreateAccessKey",
    ]
  }
}

module "deny_user_creation_scp" {
  source = "../modules/scp"

  policy_name      = "DenyUserCreationSCP"
  description      = "Deny Creation of Users in all accounts except Identity"
  policy_file_json = data.aws_iam_policy_document.deny_user_creation_scp.json
  account_ids      = [aws_organizations_organizational_unit.prod.id, aws_organizations_organizational_unit.dev.id]

  depends_on = [resource.aws_organizations_organization.root]
}

data "aws_iam_policy_document" "instance_type_limit_scp" {
  statement {
    sid       = "LimitEC2Instances"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["ec2:*"]

    condition {
      test     = "ForAnyValue:StringNotLike"
      variable = "ec2:InstanceType"

      values = [
        "*.micro",
        "*.medium",
        "*.small",
        "*.nano",
      ]
    }
  }

  statement {
    sid       = "LimitRDSInstances"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["rds:*"]

    condition {
      test     = "ForAnyValue:StringNotLike"
      variable = "rds:DatabaseClass"

      values = [
        "*.micro",
        "*.small",
        "*.nano",
      ]
    }
  }
}

module "instance_type_limit_scp" {
  source = "../modules/scp"

  policy_name      = "InstanceTypeLimitSCP"
  description      = "Restrict EC2 and DB instance types for dev environment"
  policy_file_json = data.aws_iam_policy_document.instance_type_limit_scp.json
  account_ids      = [aws_organizations_organizational_unit.dev.id]

  depends_on = [resource.aws_organizations_organization.root]
}

data "aws_iam_policy_document" "ebs_rds_encryption_scp" {
  statement {
    sid       = "DenyUnEncryptedEBSVolumes"
    effect    = "Deny"
    resources = ["arn:aws:ec2:*:*:volume/*"]
    actions   = ["ec2:CreateVolume"]

    condition {
      test     = "Bool"
      variable = "ec2:Encrypted"
      values   = ["false"]
    }
  }

  statement {
    sid       = "DenyUnEncryptedRDS"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["rds:CreateDBInstance"]

    condition {
      test     = "Bool"
      variable = "rds:StorageEncrypted"
      values   = ["false"]
    }
  }
}

module "ebs_rds_encryption_scp" {
  source = "../modules/scp"

  policy_name      = "EBSRDSEncryptionSCP"
  description      = "EBS Blocks and RDS Storage must be encrypted"
  policy_file_json = data.aws_iam_policy_document.ebs_rds_encryption_scp.json

  account_ids = [module.prod_account.id]

  depends_on = [resource.aws_organizations_organization.root]
}

data "aws_iam_policy_document" "region_lock_scp" {
  statement {
    sid       = "RegionLockPolicy"
    effect    = "Deny"
    resources = ["*"]

    not_actions = [
      "acm:*",
      "awsbillingconsole:*",
      "budgets:*",
      "ce:*",
      "globalaccelerator:*",
      "health:*",
      "iam:*",
      "kms:*",
      "networkmanager:*",
      "organizations:*",
      "pricing:*",
      "route53:*",
      "route53domains:*",
      "sts:*",
      "support:*",
      "s3:*",
    ]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"

      values = [
        "us-east-1",
        "us-east-2",
        "us-west-1",
        "us-west-2",
      ]
    }
  }
}

module "region_lock_scp" {
  source = "../modules/scp"

  policy_name      = "RegionLockSCP"
  description      = "Restrict AWS Services and Regions to particular values"
  policy_file_json = data.aws_iam_policy_document.region_lock_scp.json

  account_ids = [aws_organizations_organization.root.roots[0].id]

  depends_on = [resource.aws_organizations_organization.root]
}
