locals {
  instance-count       = var.instance-enabled ? var.instance-count : 0
  security-group-count = var.create-default-security-group ? 1 : 0
  region               = var.region != "" ? var.region : data.aws_region.default.name
  root-iops            = var.root-volume-type == "io1" ? var.root-iops : 0
  ebs-iops             = var.ebs-volume-type == "io1" ? var.ebs-iops : 0
  availability-zone    = var.availability-zone
  root-volume-type     = var.root-volume-type != "" ? var.root-volume-type : data.aws_ami.info.root_device_type
  count-default-ips    = var.associate-public-ip-address && var.assign-eip-address && var.instance-enabled ? var.instance-count : 0
  ssh-key-pair-path    = var.ssh-key-pair-path == "" ? path.cwd : var.ssh-key-pair-path
}

locals {
  public-ips = compact(
    concat(
      coalescelist(aws_eip.default.*.public_ip, aws_instance.default.*.public_ip),
      coalescelist(aws_eip.additional.*.public_ip, [""])
    )
  )

  ip-dns-list = split(",", replace(join(",", local.public-ips), ".", "-"))

  dns-names = formatlist(
    "%v.${var.region == "us-east-1" ? "compute-1" : "${var.region}.compute"}.amazonaws.com", compact(local.ip-dns-list)
  )
}

module "ebs-volume-tags" {
  source = "../tags"

  name        = var.ebs-volume-name
  project     = var.project
  environment = var.environment
  owner       = var.owner

  tags = {
    Description = "managed by terraform",
  }
}

module "ec2-instance-tags" {
  source = "../tags"

  name        = var.name
  project     = var.project
  environment = var.environment
  owner       = var.owner

  tags = {
    Description = "managed by terraform",
  }
}

data "aws_region" "default" {
}

data "aws_caller_identity" "default" {
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = "ec2defaultpolicy"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_ami" "info" {
  filter {
    name   = "image-id"
    values = [var.ami]
  }

  owners = [var.ami-owner]
}

resource "aws_iam_instance_profile" "default" {
  count = signum(local.instance-count)
  name  = var.iam-instance-profile-name
  role  = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role" "default" {
  count                = signum(local.instance-count)
  name                 = var.iam-role-default-name
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.default.json
  permissions_boundary = length(var.permissions-boundary-arn) > 0 ? var.permissions-boundary-arn : null
}

resource "aws_instance" "default" {
  count                       = local.instance-count
  ami                         = data.aws_ami.info.id
  availability_zone           = local.availability-zone
  instance_type               = var.instance-type
  ebs_optimized               = var.ebs-optimized
  disable_api_termination     = var.disable-api-termination
  user_data                   = var.user-data
  iam_instance_profile        = join("", aws_iam_instance_profile.default.*.name)
  associate_public_ip_address = var.associate-public-ip-address
  key_name                    = signum(length(var.ssh-key-pair)) == 1 ? var.ssh-key-pair : module.ssh_key_pair.key_name
  subnet_id                   = var.subnet
  monitoring                  = var.monitoring
  private_ip                  = concat(var.private-ips, [""])[min(length(var.private-ips), count.index)]
  source_dest_check           = var.source-dest-check
  ipv6_address_count          = var.ipv6-address-count < 0 ? null : var.ipv6-address-count
  ipv6_addresses              = length(var.ipv6-addresses) > 0 ? var.ipv6-addresses : null

  vpc_security_group_ids = compact(
    concat(
      [
        var.create-default-security-group ? join("", aws_security_group.default.*.id) : ""
      ],
      var.security-groups
    )
  )

  root_block_device {
    volume_type           = local.root-volume-type
    volume_size           = var.root-volume-size
    iops                  = local.root-iops
    delete_on_termination = var.delete-on-termination
  }

  tags              = module.ec2-instance-tags.tags
}

##
## Create keypair if one isn't provided
##

module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-aws-key-pair.git?ref=tags/0.9.0"
  namespace             = var.namespace
  environment           = var.environment
  stage                 = var.stage
  name                  = var.name
  ssh_public_key_path   = local.ssh-key-pair-path
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
  generate_ssh_key      = var.generate-ssh-key-pair
}

resource "aws_eip" "default" {
  count             = local.count-default-ips
  network_interface = aws_instance.default.*.primary_network_interface_id[count.index]
  vpc               = true
  depends_on        = [aws_instance.default]
}

resource "aws_ebs_volume" "default" {
  count             = var.ebs-volume-count * local.instance-count
  availability_zone = local.availability-zone
  size              = var.ebs-volume-size
  iops              = local.ebs-iops
  type              = var.ebs-volume-type
  tags              = module.ebs-volume-tags.tags
}

resource "aws_volume_attachment" "default" {
  count       = signum(local.instance-count) == 1 ? var.ebs-volume-count * local.instance-count : 0
  device_name = element(slice(var.ebs-device-names, 0, floor(var.ebs-volume-count * local.instance-count / max(local.instance-count, 1))), count.index)
  volume_id   = aws_ebs_volume.default.*.id[count.index]
  instance_id = aws_instance.default.*.id[count.index]
}