# Spool out Account IDs for using in the Infrastructure Module
output "account_ids" {
  value = {
    identity = module.identity_account.id
    prod     = module.prod_account.id
    dev      = module.dev_account.id
  }
}

# Quick Links for accessing the various AWS Organization accounts
output "links" {
  value = {
    aws_console_sign_identity_account = "https://${module.identity_account.id}.signin.aws.amazon.com/console/"
    switch_role_dev_admin             = "https://signin.aws.amazon.com/switchrole?account=${module.dev_account.id}&roleName=${urlencode(module.dev.assume_admin_role_with_mfa_name)}&displayName=${urlencode("Admin@Dev")}"
    switch_role_identity_admin        = "https://signin.aws.amazon.com/switchrole?account=${module.identity_account.id}&roleName=${urlencode(module.identity.iam_admin_role_name)}&displayName=${urlencode("Admin@Identity")}"
    switch_role_prod_admin            = "https://signin.aws.amazon.com/switchrole?account=${module.prod_account.id}&roleName=${urlencode(module.prod.assume_admin_role_with_mfa_name)}&displayName=${urlencode("Admin@Prod")}"
    switch_role_prod_readonly         = "https://signin.aws.amazon.com/switchrole?account=${module.prod_account.id}&roleName=${urlencode(module.prod.assume_readonly_role_name)}&displayName=${urlencode("ReadOnly@Prod")}"
  }
}

# Spool out temporary passwords and access keys of users created.
output "users" {
  value = {
    for user in var.users :
    user.username => {
      temp_password         = module.users[user.username].temp_password
      role_arns_assigned    = local.user_role_mapping[user.role]
      aws_access_key_id     = module.users_access_keys[user.username].aws_access_key_id
      aws_access_key_secret = module.users_access_keys[user.username].aws_access_key_secret
    }
  }
}

# Spool out ARNs of OIDCECRAdmin Roles
output "GithubOIDCECRRole" {
  value = {
    prod_oidc_ecr = module.prod.assume_oidc_ecr_role
    dev_oidc_ecr = module.dev.assume_oidc_ecr_role
  }
}