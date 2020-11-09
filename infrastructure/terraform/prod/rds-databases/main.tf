module "rds_instance" {
  source = "../modules/rds"
  name   = "review-aggregator-db"
  #dns_zone_id                 = "Z89FN1IW975KPE"  // Currently we don't need to public our DB
  host_name = "review-aggregator-db"
  #security_group_ids          = [aws_security_group.rds-review-aggregator.id] // Let's Terraform create default security group for this rds
  ca_cert_identifier   = "rds-ca-2019"
  allowed_cidr_blocks  = ["0.0.0.0/0"]
  database_name        = "review_aggregator"
  database_user        = "root"
  database_password    = random_password.review-aggregator-db.result
  database_port        = 5432
  multi_az             = true
  storage_type         = "gp2"
  allocated_storage    = 10
  storage_encrypted    = false
  engine               = "postgres"
  engine_version       = "10.6"
  major_engine_version = "10"
  instance_class       = "db.t2.micro"
  db_parameter_group   = "postgres10"
  #option_group_name           = "mysql-options" // Currently we don't have option group for our rds
  publicly_accessible = false
  subnet_ids          = [data.terraform_remote_state.network.outputs.private-subnet-0.id, data.terraform_remote_state.network.outputs.private-subnet-1.id]
  vpc_id              = data.terraform_remote_state.network.outputs.review-aggregator-vpc.id
  #snapshot_identifier         = "rds:review-aggregator" // If you want to restore rds from a snapshot, use this parameter
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  apply_immediately           = false
  maintenance_window          = "Mon:03:00-Mon:04:00"
  skip_final_snapshot         = false
  copy_tags_to_snapshot       = true
  backup_retention_period     = 7
  backup_window               = "22:00-03:00"
  project                     = "review-aggregator"
  owner                       = "review-aggregator"
  environment                 = "prod"
}

resource "random_password" "review-aggregator-db" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "review-aggregator-db-password" {
  name        = "review-aggregator-db-password"
  description = "Encryted database password"
  type        = "SecureString"
  value       = random_password.review-aggregator-db.result
}
