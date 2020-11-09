module "lambda-new-user-handler-tags" {
  source = "../tags"

  name        = "new-user-handler-VPC-endpoint"
  project     = "review-aggregator"
  environment = "prod"
  owner       = "review-aggregator"

  tags = {
    Description = "managed by Terraform"
  }
}

module "lambda-nat-gw-tags" {
  source = "../tags"

  name        = "new-user-handler-nat-gw"
  project     = "review-aggregator"
  environment = "prod"
  owner       = "review-aggregator"

  tags = {
    Description = "managed by Terraform"
  }
}

module "lambda-eip-tags" {
  source = "../tags"

  name        = "new-user-handler-nat-gw-eip"
  project     = "review-aggregator"
  environment = "prod"
  owner       = "review-aggregator"

  tags = {
    Description = "managed by Terraform"
  }
}

resource "aws_internet_gateway" "reviewAggregator" {
  vpc_id = aws_vpc.reviewAggregator.id

  tags = var.tags
}

resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.reviewAggregator.id

  route {
    //machine in this subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.reviewAggregator.id
  }

  tags = merge(
    var.tags,
    {
      Name = "review-aggregator-public-crt"
    }
  )
}

resource "aws_route_table" "prod-private-crt" {
  vpc_id = aws_vpc.reviewAggregator.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw[0].id
  }

  tags = merge(
    var.tags,
    {
      Name = "review-aggregator-private-crt"
    }
  )
}

resource "aws_vpc_endpoint" "s3" {
  count        = var.vpc-endpoint-s3-enable ? 1 : 0
  vpc_id       = aws_vpc.reviewAggregator.id
  service_name = "com.amazonaws.us-east-2.s3"

  tags = module.lambda-new-user-handler-tags.tags
}

resource "aws_eip" "nat-gw" {
  count = var.nat-gw-enable ? 1 : 0
  vpc   = true

  tags = module.lambda-eip-tags.tags
}

resource "aws_nat_gateway" "nat-gw" {
  count         = var.nat-gw-enable ? 1 : 0
  allocation_id = aws_eip.nat-gw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = module.lambda-nat-gw-tags.tags
}

resource "aws_route_table_association" "prod-crta-public" {
  for_each       = var.public-subnet-numbers
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.prod-public-crt.id
}

resource "aws_route_table_association" "prod-crta-private" {
  for_each       = var.private-subnet-numbers
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.prod-private-crt.id
}

# resource "aws_main_route_table_association" "prod-crta-public" {
#   vpc_id         = aws_vpc.reviewAggregator.id
#   route_table_id = aws_route_table.prod-public-crt.id
# }

# resource "aws_default_route_table" "prod-crta-public" {
#   default_route_table_id = aws_route_table.prod-public-crt.id
# }
