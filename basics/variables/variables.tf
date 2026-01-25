variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = false
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "project-alpha"
}

variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "dev"
}

variable "vpc_module_version" {
  description = "Version of the VPC Terraform module"
  type        = string
  default     = "2.64.0"
}

variable "security_group_module_version" {
  description = "Version of the Security Group Terraform module"
  type        = string
  default     = "3.17.0"
}

variable "elb_module_version" {
  description = "Version of the ELB Terraform module"
  type        = string
  default     = "2.4.0"
}

variable "random_string_length" {
  description = "Length of random string for load balancer name uniqueness"
  type        = number
  default     = 3
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "health_check_target" {
  description = "Health check target for the load balancer"
  type        = string
  default     = "HTTP:80/index.html"
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 10
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health checks to mark instance as healthy"
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures to mark instance as unhealthy"
  type        = number
  default     = 10
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}