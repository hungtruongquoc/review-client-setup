module "review-aggregator-network-label" {
  source = "../modules/tags"

  name        = "vpc"
  project     = "review-aggregator"
  environment = "prod"
  owner       = "review-aggregator"

  tags = {
    Description = "managed by terraform",
  }
}

module "review-aggregator-network" {
  source = "../modules/network"

  vpc-cidr-block = var.vpc-cidr-block

  public-subnet-numbers    = var.public-subnet-numbers
  private-subnet-numbers   = var.private-subnet-numbers

  project                   = var.project-name
  environment               = var.environment
  owner                     = var.owner

  tags = module.review-aggregator-network-label.tags
}
