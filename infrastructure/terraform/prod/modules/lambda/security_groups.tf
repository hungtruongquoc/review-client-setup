module "security-group-tags" {
  source = "../tags"

  name        = var.security-group-name
  project     = var.project
  environment = var.environment
  owner       = var.owner

  tags = {
    Description = "managed by Terraform",
  }
}

resource "aws_security_group" "default" {
  count       = local.security-group-count
  name        = module.security-group-tags.name
  vpc_id      = var.vpc-id
  description = "Instance default security group (only egress access is allowed)"
  tags        = module.security-group-tags.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress" {
  count             = var.create-default-security-group ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "ingress" {
  count             = var.create-default-security-group ? length(compact(var.allowed-ports)) : 0
  type              = "ingress"
  from_port         = var.allowed-ports[count.index]
  to_port           = var.allowed-ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}
