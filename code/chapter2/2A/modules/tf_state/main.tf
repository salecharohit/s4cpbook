resource "random_id" "bucket_id" {
  byte_length = 5
}

resource "random_id" "table_id" {
  byte_length = 5
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "s3-bucket-${var.account}-${random_id.bucket_id.hex}"
  force_destroy = true
  tags = {
    Name              = "Terraform State Bucket"
    terraform-managed = "true"
    Account           = var.account
  }
}

resource "aws_s3_bucket_ownership_controls" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_bucket" {
  bucket     = aws_s3_bucket.terraform_state_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.terraform_state_bucket]
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "dynamodb-${var.account}-${random_id.table_id.hex}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name              = "Terraform State Lock Table"
    terraform-managed = "true"
    Account           = var.account
  }
}
