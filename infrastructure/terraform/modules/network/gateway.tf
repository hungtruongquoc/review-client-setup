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

  tags = var.tags
}

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  for_each       = var.public-subnet-numbers
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.prod-public-crt.id
}
