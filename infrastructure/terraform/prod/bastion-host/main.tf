module "bastion-host" {
  source                        = "../modules/ec2"
  name                          = "Bastion-host"
  ami                           = "ami-07efac79022b86107"
  ami-owner                     = "099720109477" // Amazon is the owner
  region                        = "us-east-2"
  instance-type                 = var.instance-type
  root-volume-size               = 10
  vpc-id                        = data.terraform_remote_state.network.outputs.review-aggregator-vpc.id
  security-group-name           = var.security-group-name
  ebs-volume-count              = 0 // increase this value if you want to add more disk
  allowed-ports                 = [22]
  assign-eip-address            = false
  create-default-security-group = true
  generate-ssh-key-pair         = true
  ssh-key-pair-path             = "./"
  subnet                        = data.terraform_remote_state.network.outputs.public-subnet-1.id
  availability-zone             = data.terraform_remote_state.network.outputs.public-subnet-1.availability_zone
  instance-count                = 1
  iam-role-default-name         = var.iam-role-default-name
  iam-instance-profile-name     = var.iam-instance-profile-name
  owner                         = var.owner
  project                       = var.project
  environment                   = var.environment
  ebs-volume-name               = "volume of the Bastion host"
}
