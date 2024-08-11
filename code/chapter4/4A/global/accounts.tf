variable "github_account_repo" {
  description = "Github Account and Repository that will be interacting with AWS OIDC"
  default       = "<username>/playground" #@CHANGEME
  type        = string
}

# Create all Identity Account resources
module "identity" {
  source = "./identity"

  providers = {
    aws = aws.identity
  }

}

# Create all Prod Account resources
module "prod" {
  source = "./prod"

  account             = "prod"
  identity_account_id = module.identity_account.id
  domain              = "prod.${var.domain}"
  github_account_repo = var.github_account_repo
  providers = {
    aws = aws.prod
  }

}

# Create all Prod Account resources
module "dev" {
  source = "./dev"

  account             = "dev"
  identity_account_id = module.identity_account.id
  domain              = "dev.${var.domain}"
  github_account_repo = var.github_account_repo

  providers = {
    aws = aws.dev
  }

}