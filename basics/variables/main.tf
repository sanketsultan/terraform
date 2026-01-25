terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = var.vpc_module_version

  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}

module "app_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = var.security_group_module_version

  name        = "web-sg-${var.project_name}-${var.environment}"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}

module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = var.security_group_module_version

  name        = "lb-sg-${var.project_name}-${var.environment}"
  description = "Security group for load balancer with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}

resource "random_string" "lb_id" {
  length  = var.random_string_length
  special = false
}

module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = var.elb_module_version

  # Ensure load balancer name is unique
  name = "lb-${random_string.lb_id.result}-${var.project_name}-${var.environment}"

  internal = false

  security_groups = [module.lb_security_group.this_security_group_id]
  subnets         = module.vpc.public_subnets

  number_of_instances = length(module.ec2_instances.instance_ids)
  instances           = module.ec2_instances.instance_ids

  listener = [{
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }]

  health_check = {
    target              = var.health_check_target
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
  }

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}

module "ec2_instances" {
  source = "./modules/aws-instance"

  instance_count     = var.instance_count
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.private_subnets[*]
  security_group_ids = [module.app_security_group.this_security_group_id]

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}