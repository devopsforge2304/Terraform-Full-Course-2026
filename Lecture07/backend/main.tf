provider "aws" {
    region = "us-east-1"
  
}

resource "aws_s3_bucket" "state_bucket" {

    bucket = "rahul-terraform-practical06-state-bucket"
  
}

resource "aws_s3_bucket_server_side_encryption_configuration" "enc" {

    bucket = aws_s3_bucket.state_bucket.id

    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  
}

resource "aws_s3_bucket_versioning" "versioning" {

    bucket = aws_s3_bucket.state_bucket.id

    versioning_configuration {
      status = "Enabled"
    }
  
}

resource "aws_s3_bucket_public_access_block" "block" {

    bucket = aws_s3_bucket.state_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
  
}

resource "aws_dynamodb_table" "lock_table" {
  name = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }


}