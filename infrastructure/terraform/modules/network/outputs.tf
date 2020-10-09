output "reviewAggregator-vpc" {
  value = "${aws_vpc.reviewAggregator}"
}

output "db-subnet-group" {
  value = "${aws_db_subnet_group.private-subnet-1}"
}

output "public-subnet-0" {
  value = "${aws_subnet.public[0]}"
}

output "public-subnet-1" {
  value = "${aws_subnet.public[1]}"
}

output "public-subnet-2" {
  value = "${aws_subnet.public[2]}"
}

output "private-subnet-0" {
  value = "${aws_subnet.private[0]}"
}

output "private-subnet-1" {
  value = "${aws_subnet.private[1]}"
}

output "private-subnet-2" {
  value = "${aws_subnet.private[2]}"
}
