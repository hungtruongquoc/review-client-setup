variable "aws-region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

variable "name" {}

variable "project-name" {}

variable "environment" {}

variable "owner" {}

variable "vpc-cidr-block" {}

variable "public-subnet-numbers" {}

variable "private-subnet-numbers" {}
