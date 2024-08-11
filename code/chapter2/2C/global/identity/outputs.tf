output "iam_admin_role_name" {
  value = module.assume_iam_admin_role_with_mfa.role_name
}

output "iam_admin_role_arn" {
  value = module.assume_iam_admin_role_with_mfa.role_arn
}

output "group_self_manage" {
  value = aws_iam_group.self_manage.name
}
