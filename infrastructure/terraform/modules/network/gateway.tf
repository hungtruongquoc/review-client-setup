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
}

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.prod-public-crt.id
}

  // Allow access to database port for basion host
#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
