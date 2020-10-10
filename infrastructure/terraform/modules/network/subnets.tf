module "subnet-tags" {
  source = "../tags"

  project     = var.project
  environment = var.environment
  owner       = var.owner

  tags = {
    Description = "managed by terraform",
  }
}
resource "aws_subnet" "public" {
  for_each                = var.public-subnet-numbers
  vpc_id                  = aws_vpc.reviewAggregator.id
  cidr_block              = each.value
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.availability-zones[each.key]

  tags                    = merge(
    module.subnet-tags.tags,
    {
      Name = "${var.project}-public-${each.key}"
    }
  )
}

resource "aws_subnet" "private" {
  for_each = var.private-subnet-numbers
  vpc_id   = aws_vpc.reviewAggregator.id
  #cidr_block              = lookup(var.public_subnet_numbers, 0)
  cidr_block              = each.value
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability-zones[each.key]

  tags                    = merge(
    module.subnet-tags.tags,
    {
      Name = "${var.project}-private-${each.key}"
    }
  )
}

resource "aws_db_subnet_group" "private-subnet-1" {
  name                    = "private-subnet"
  subnet_ids              = [aws_subnet.private[0].id, aws_subnet.private[1].id]

  tags                    = module.subnet-tags.tags
}
