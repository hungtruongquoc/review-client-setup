vpc-cidr-block = "10.0.0.0/16"

public-subnet-numbers = {
  0 = "10.0.0.0/20"
  1 = "10.0.16.0/20"
  2 = "10.0.32.0/20"
}

private-subnet-numbers = {
  0 = "10.0.48.0/20"
  1 = "10.0.64.0/20"
  2 = "10.0.80.0/20"
}

name  = "main-network"

project-name = "review-aggregator"

environment = "prod"

owner = "review-aggregator"
