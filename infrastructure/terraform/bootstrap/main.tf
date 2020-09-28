resource "aws_kms_key" "terraform_bootstrap" {
  description             = "Terraform KMS key"
  deletion_window_in_days = 14
}

resource "aws_kms_alias" "terraform_bootstrap" {
  name          = "alias/bootstrap"
  target_key_id = aws_kms_key.terraform_bootstrap.key_id
  depends_on    = [aws_kms_key.terraform_bootstrap]
}

resource "aws_s3_bucket" "terraform_state" {
  bucket              = "review-aggregator-tfstate"
  acceleration_status = "Enabled"
  acl                 = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.terraform_bootstrap.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Terraform State"
    Description = "Managed by Terraform"
  }

  depends_on = [aws_kms_key.terraform_bootstrap, aws_kms_alias.terraform_bootstrap]
}

resource "aws_dynamodb_table" "bootstrap_state_table" {
  name           = "bootstrap-tf-lock"
  hash_key       = "LockID"
  read_capacity  = 3
  write_capacity = 3
  billing_mode   = "PROVISIONED"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  depends_on = [aws_s3_bucket.terraform_state]
}

# We will create ECR repo later 
#resource "aws_ecr_repository" "review_aggregator" {
#  name                 = "fixme"
#  image_tag_mutability = "MUTABLE"
#
#  image_scanning_configuration {
#    scan_on_push = true
#  }
#}
