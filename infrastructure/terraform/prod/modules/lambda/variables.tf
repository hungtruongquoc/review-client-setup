variable "create-default-security-group" {}

variable "security-group-name" {}

variable "project" {}

variable "environment" {}

variable "owner" {}

variable "vpc-id" {}

variable "allowed-ports" {
    type = list(number)
    description = "A list of allowed ports"
    default = []
}

