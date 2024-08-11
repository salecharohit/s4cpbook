output "aws_access_key_id" {
  value = aws_iam_access_key.default.id
}

output "aws_access_key_secret" {
  value = aws_iam_access_key.default.encrypted_secret
}