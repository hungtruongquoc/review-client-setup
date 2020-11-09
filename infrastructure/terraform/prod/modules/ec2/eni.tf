module "eni-tags" {
  source = "../tags"

  name        = var.eni-name
  project     = var.project
  environment = var.environment
  owner       = var.owner

  tags = {
    Description = "managed by terraform",
  }
}

locals {
  additional-ips-count = var.associate-public-ip-address && var.instance-enabled && var.additional-ips-count > 0 ? var.additional-ips-count : 0
}

resource "aws_network_interface" "additional" {
  count     = local.additional-ips-count * var.instance-count
  subnet_id = var.subnet

  security_groups = compact(
    concat(
      [
        var.create-default-security-group ? join("", aws_security_group.default.*.id) : ""
      ],
      var.security-groups
    )
  )

  tags       = module.eni-tags.tags
  depends_on = [aws_instance.default]
}

resource "aws_network_interface_attachment" "additional" {
  count                = local.additional-ips-count * var.instance-count
  instance_id          = aws_instance.default.*.id[count.index % var.instance-count]
  network_interface_id = aws_network_interface.additional.*.id[count.index]
  device_index         = 1 + count.index
  depends_on           = [aws_instance.default]
}

resource "aws_eip" "additional" {
  count             = local.additional-ips-count * var.instance-count
  vpc               = true
  network_interface = aws_network_interface.additional.*.id[count.index]
  depends_on        = [aws_instance.default]
}