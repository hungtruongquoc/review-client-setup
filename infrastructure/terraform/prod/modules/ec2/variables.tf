variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "iam-role-default-name" {
  type    = string
  default = ""
}

variable "iam-instance-profile-name" {
  type    = string
  default = ""
}

variable "eni-name" {
  type    = string
  default = ""
}

variable "project" {
  type        = string
  description = "project name"
  default     = ""
}

variable "owner" {
  type        = string
  description = "owner name"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of the application"
}

variable "security-group-name" {
  type        = string
  description = "Name of Security group"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "ssh-key-pair" {
  type        = string
  description = "SSH key pair to be provisioned on the instance"
  default     = ""
}

variable "generate-ssh-key-pair" {
  type        = bool
  description = "If true, create a new key pair and save the pem for it to the current working directory"
  default     = false
}

variable "associate-public-ip-address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = true
}

variable "ssh-key-pair-path" {
  type        = string
  description = "Path to where the generated key pairs will be created. Defaults to $$${path.cwd}"
  default     = ""
}

variable "assign-eip-address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
  default     = true
}

variable "user-data" {
  type        = string
  description = "Instance user data. Do not pass gzip-compressed data via this argument"
  default     = ""
}

variable "instance-type" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}

variable "vpc-id" {
  type        = string
  description = "The ID of the VPC that the instance security group belongs to"
}

variable "security-groups" {
  description = "List of Security Group IDs allowed to connect to the instance"
  type        = list(string)
  default     = []
}

variable "allowed-ports" {
  type        = list(number)
  description = "List of allowed ingress ports"
  default     = []
}

variable "subnet" {
  type        = string
  description = "VPC Subnet ID the instance is launched in"
}

variable "region" {
  type        = string
  description = "AWS Region the instance is launched in"
  default     = "us-east-2"
}

variable "availability-zone" {
  type        = string
  description = "Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region"
  default     = ""
}

variable "ami" {
  type        = string
  description = "The AMI to use for the instance"
}

variable "ami-owner" {
  type        = string
  description = "Owner of the given AMI"
}

variable "ebs-optimized" {
  type        = bool
  description = "Launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable-api-termination" {
  type        = bool
  description = "Enable EC2 Instance Termination Protection"
  default     = false
}

variable "monitoring" {
  type        = bool
  description = "Launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "private-ips" {
  type        = list(string)
  description = "Private IP address to associate with the instances in the VPC"
  default     = []
}

variable "source-dest-check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs"
  default     = true
}

variable "ipv6-address-count" {
  type        = number
  description = "Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  default     = 0
}

variable "ipv6-addresses" {
  type        = list(string)
  description = "List of IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}

variable "root-volume-type" {
  type        = string
  description = "Type of root volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "root-volume-size" {
  type        = number
  description = "Size of the root volume in gigabytes"
  default     = 10
}

variable "root-iops" {
  type        = number
  description = "Amount of provisioned IOPS. This must be set if root_volume_type is set to `io1`"
  default     = 0
}

variable "ebs-device-names" {
  type        = list(string)
  description = "Name of the EBS device to mount"
  default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
}

variable "ebs-volume-name" {
  type        = string
  description = "Name of EBS volume"
  default     = ""
}

variable "ebs-volume-type" {
  type        = string
  description = "The type of EBS volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "ebs-volume-size" {
  type        = number
  description = "Size of the EBS volume in gigabytes"
  default     = 10
}

variable "ebs-iops" {
  type        = number
  description = "Amount of provisioned IOPS. This must be set with a volume_type of io1"
  default     = 0
}

variable "ebs-volume-count" {
  type        = number
  description = "Count of EBS volumes that will be attached to the instance"
  default     = 0
}

variable "delete-on-termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination"
  default     = true
}

variable "welcome-message" {
  type        = string
  description = "Welcome message"
  default     = ""
}

variable "comparison-operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. Possible values are: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  default     = "GreaterThanOrEqualToThreshold"
}

variable "metric-name" {
  type        = string
  description = "The name for the alarm's associated metric. Allowed values can be found in https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ec2-metricscollected.html"
  default     = "StatusCheckFailed_Instance"
}

variable "evaluation-periods" {
  type        = number
  description = "The number of periods over which data is compared to the specified threshold"
  default     = 5
}

variable "metric-namespace" {
  type        = string
  description = "The namespace for the alarm's associated metric. Allowed values can be found in https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-namespaces.html"
  default     = "AWS/EC2"
}

variable "applying-period" {
  type        = number
  description = "The period in seconds over which the specified statistic is applied"
  default     = 60
}

variable "statistic-level" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric. Allowed values are: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Maximum"
}

variable "metric-threshold" {
  type        = number
  description = "The value against which the specified statistic is compared"
  default     = 1
}

variable "default-alarm-action" {
  type        = string
  description = "Default alarm action"
  default     = "action/actions/AWS_EC2.InstanceId.Reboot/1.0"
}

variable "create-default-security-group" {
  type        = bool
  description = "Create default Security Group with only Egress traffic allowed"
  default     = true
}

variable "instance-enabled" {
  type        = bool
  description = "Flag to control the instance creation. Set to false if it is necessary to skip instance creation"
  default     = true
}

variable "additional-ips-count" {
  type        = number
  description = "Count of additional EIPs"
  default     = 0
}

variable "instance-count" {
  type        = number
  description = "Count of ec2 instances to create"
  default     = 1
}

variable "permissions-boundary-arn" {
  type        = string
  description = "Policy ARN to attach to instance role as a permissions boundary"
  default     = ""
}