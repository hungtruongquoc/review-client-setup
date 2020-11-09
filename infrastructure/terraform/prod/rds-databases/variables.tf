variable "security-group-name" {}

variable "project" {}

variable "environment" {}

variable "owner" {}

variable "allowed-ports" {
  type        = list(number)
  description = "List of allowed ingress ports"
  default     = []
}
