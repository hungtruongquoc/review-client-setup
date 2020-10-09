vpc-cidr-block = "10.0.0.0/16"

db-egress-cidr           = ["0.0.0.0/0"]
db-ingress-cidr          = ["10.0.0.0/24"]
bastion-egress-cidr      = ["0.0.0.0/0"]
bastion-ingress-ssh-cidr = ["0.0.0.0/0"]
bastion-ingress-db-cidr  = ["0.0.0.0/0"]

public-subnet-numbers = {
  0 = "10.0.0.0/24"
  1 = "10.0.1.0/24"
  2 = "10.0.2.0/24"
}

private-subnet-numbers = {
  0 = "10.0.3.0/24"
  1 = "10.0.4.0/24"
  2 = "10.0.5.0/24"
}
