module "review-aggregator-network-label" {
  source = "../modules/tags"

  name        = "vpc"
  project     = "review-aggregator"
  environment = "prod"
  owner       = "review-aggregator"

  tags = {
    Description = "manage by terraform",
  }
}

module "review-aggregator-network" {
  source = "../modules/network"

  vpc-cidr-block = var.vpc-cidr-block

  db-egress-cidr           = var.db-egress-cidr
  db-ingress-cidr          = var.db-ingress-cidr
  bastion-egress-cidr      = var.bastion-egress-cidr
  bastion-ingress-ssh-cidr = var.bastion-ingress-ssh-cidr
  bastion-ingress-db-cidr  = var.bastion-ingress-db-cidr

  public-subnet-numbers  = var.public-subnet-numbers
  private-subnet-numbers = var.private-subnet-numbers

  tags = module.review-aggregator-network-label.tags
}
