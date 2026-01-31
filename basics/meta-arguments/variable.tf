variable "aws_region" {
    description = "AWS region for resource deployment"
    type        = string
    default     = "us-east-1"
}

variable "environment" {
    description = "Environment name (dev, staging, prod)"
    type        = string
    validation {
        condition     = contains(["dev", "staging", "prod"], var.environment)
        error_message = "Environment must be dev, staging, or prod."
    }
}

variable "resource_prefix" {
    description = "Prefix for AWS resource names"
    type        = string
}