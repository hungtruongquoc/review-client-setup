variable "aws-region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

variable "vpc-cidr-block" {}

variable "db-egress-cidr" {}

variable "db-ingress-cidr" {}

variable "bastion-egress-cidr" {}

variable "bastion-ingress-ssh-cidr" {}

variable "bastion-ingress-db-cidr" {}

variable "public-subnet-numbers" {}

variable "private-subnet-numbers" {}
