variable "namespace" {}

# variable "ssh_key_pair" {}
variable "stage" {}

variable "project" {}

variable "environment" {}

variable "owner" {}

variable "instance-type" {
    default = "t2.micro"
}

variable "iam-role-default-name" {}

variable "iam-instance-profile-name" {}

# variable "tags" {}

# variable "vpc_id" {}

variable "security-group-name" {}

# variable "subnet" {}
