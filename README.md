# Terraform Infrastructure

This repository contains Terraform code for provisioning and managing cloud infrastructure using Infrastructure as Code (IaC).

## Prerequisites

- Terraform installed (v1.x recommended)
- Configured cloud credentials (e.g., AWS CLI, Azure CLI, or GCP SDK)

## Usage

Initialize the working directory:

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

## terraform state

```bash
terraform state list
terraform state list aws_s3_bucket.<bucket-name>
terrform state show aws_s3_bucket.<bucket-name>
terraform state mv SOURCE DESTINATION
terraform state rm ADDRESS
