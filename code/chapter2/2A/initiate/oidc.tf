variable "github_account_repo" {
  description = "Github Account and Repository that will be interacting with AWS OIDC"
  default       = "<username>/playground" #@CHANGEME
  type        = string
}


module "github_oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "~> 1"

  create_oidc_provider = true
  create_oidc_role     = true
  role_name            = "GithubOIDCGlobalAdmin"
  repositories              = ["${var.github_account_repo}"]
  oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

output "github_oidc_global_role" {
  value       = module.github_oidc.oidc_role
  description = "Global OIDC Role"
}