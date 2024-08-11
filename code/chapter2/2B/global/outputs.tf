# Spool out Account IDs for using in the Infrastructure Module
output "account_ids" {
  value = {
    identity = module.identity_account.id
    prod     = module.prod_account.id
    dev      = module.dev_account.id
  }
}