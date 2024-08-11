resource "aws_iam_access_key" "default" {
  user    = var.username
  pgp_key = var.pgp_key
  status  = var.status
}