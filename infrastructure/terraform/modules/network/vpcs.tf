resource "aws_vpc" "reviewAggregator" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_hostnames = "true"

  tags = var.tags
}
