output "role_name" {
  value = aws_iam_role.default.name
}

output "role_arn" {
  value = aws_iam_role.default.arn
}

output "sa_name" {
  value = resource.kubernetes_service_account.default.metadata[0].name
}
