# ─────────────────────────────────────────────
# S3 bucket for Terraform state
# ─────────────────────────────────────────────
resource "aws_s3_bucket" "tfstate" {
  bucket        = "tfstate-frontend-app-b6428722"
  force_destroy = false

  tags = {
    Name    = "tfstate-frontend-app"
    Purpose = "terraform-state"
  }
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket                  = aws_s3_bucket.tfstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

# ─────────────────────────────────────────────
# DynamoDB table for state locking
# ─────────────────────────────────────────────
resource "aws_dynamodb_table" "tfstate_lock" {
  name         = "tfstate-lock-frontend-app"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name    = "tfstate-lock-frontend-app"
    Purpose = "terraform-state-lock"
  }
}

# ─────────────────────────────────────────────
# S3 bucket for Elastic Beanstalk app versions
# ─────────────────────────────────────────────
resource "aws_s3_bucket" "eb_artifacts" {
  bucket        = "eb-artifacts-frontend-app-b6428722"
  force_destroy = true

  tags = {
    Name    = "eb-artifacts-frontend-app"
    Purpose = "beanstalk-app-versions"
  }
}

resource "aws_s3_bucket_versioning" "eb_artifacts" {
  bucket = aws_s3_bucket.eb_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "eb_artifacts" {
  bucket = aws_s3_bucket.eb_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "eb_artifacts" {
  bucket                  = aws_s3_bucket.eb_artifacts.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "eb_artifacts" {
  bucket = aws_s3_bucket.eb_artifacts.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}