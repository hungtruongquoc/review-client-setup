provider aws {
  region  = "us-east-2"
  profile = "review-aggregator"
}

terraform {
  backend "s3" {
    bucket         = "review-aggregator-tfstate"
    key            = "network-infra/terraform_0.12.29.tfstate"
    region         = "us-east-2"
    dynamodb_table = "review-aggregator-tf-lock"
    profile        = "review-aggregator"
    encrypt        = true
    kms_key_id     = "6ef8c1af-2577-4827-8997-c52ee72af6d4"
  }
}

terraform {
  required_version = "~> 0.12.0"
}
