module "tf_state_admin" {
  source = "../modules/tf_state"

  account = "global"
}

output "s3_bucket_name" {
  value       = module.tf_state_admin.s3_bucket_name
  description = "The Name of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = module.tf_state_admin.dynamodb_table_name
  description = "The name of the DynamoDB table"
}