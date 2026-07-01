provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "backend" {
  bucket = "terraform-statefile-prod-a"
}

resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "backend" {
  name         = "terraform-statelock-prod"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
