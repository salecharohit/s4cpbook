output "assume_admin_role_with_mfa_name" {
  value = module.assume_admin_role_with_mfa.role_name
}

output "assume_admin_role_with_mfa_arn" {
  value = module.assume_admin_role_with_mfa.role_arn
}

output "assume_readonly_role_arn" {
  value = module.assume_readonly_role.role_arn
}

output "assume_readonly_role_name" {
  value = module.assume_readonly_role.role_name
}

output "name_servers" {
  value = aws_route53_zone.default.name_servers
}