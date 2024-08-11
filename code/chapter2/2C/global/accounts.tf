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

  providers = {
    aws = aws.dev
  }

}