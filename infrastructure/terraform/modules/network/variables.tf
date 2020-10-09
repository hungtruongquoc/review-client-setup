variable "aws-region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

variable "availability-zones" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "public-subnet-numbers" {
  type = map(string)
}

variable "private-subnet-numbers" {
  type = map(string)
}

variable "tags" {}

variable "vpc-cidr-block" {}

variable "db-egress-cidr" {}

variable "db-ingress-cidr" {}

variable "bastion-egress-cidr" {}

variable "bastion-ingress-ssh-cidr" {}

variable "bastion-ingress-db-cidr" {}
