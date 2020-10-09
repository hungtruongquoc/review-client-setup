output "review-aggregator-vpc" {
  value = "${module.review-aggregator-network.reviewAggregator-vpc}"
}

output "db-subnet-group" {
  value = "${module.review-aggregator-network.db-subnet-group}"
}

output "public-subnet-1" {
  value = "${module.review-aggregator-network.public-subnet-1}"
}

output "public-subnet-2" {
  value = "${module.review-aggregator-network.public-subnet-2}"
}

output "public-subnet-3" {
  value = "${module.review-aggregator-network.public-subnet-3}"
}

output "private-subnet-1" {
  value = "${module.review-aggregator-network.private-subnet-1}"
}

output "private-subnet-2" {
  value = "${module.review-aggregator-network.public-subnet-2}"
}

output "private-subnet-3" {
  value = "${module.review-aggregator-network.public-subnet-3}"
}
