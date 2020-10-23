provider aws {
  region  = "us-east-2"
  profile = "review-aggregator"
}

terraform {
  backend "s3" {
    bucket          = "review-aggregator-tfstate"
    key             = "bastion-host/terraform.tfstate"
    region          = "us-east-2"
    dynamodb_table  = "review-aggregator-tf-lock"
    profile         = "review-aggregator"
    encrypt         = true
    kms_key_id      = "6ef8c1af-2577-4827-8997-c52ee72af6d4"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "review-aggregator-tfstate"
    region = "us-east-2"
    key    = "network-infra/terraform_0.12.29.tfstate"
    profile = "review-aggregator"
  }
}

# data "terraform_remote_state" "network" {
#   backend = "local"

#   config = {
#     path = "../network-infra/network.tfstate"
#   }
# }

terraform {
  required_version = "~> 0.12.0"
}