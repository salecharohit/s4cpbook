variable "account" {
  description = "Name of the Account"
  type        = string
}

# https://github.com/hashicorp/terraform-provider-aws/issues/15310 Leading Account with a Zero creates problems
variable "identity_account_id" {
  description = "AWS Organisation Account ID of the Identity Account"
  type        = string
}

variable "domain" {
  description = "Domain Name for Hosted Zone Configuration"
  type        = string
}
