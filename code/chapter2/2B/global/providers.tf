# Setting and locking the Dependencies to specific versions
terraform {
  required_providers {

    # AWS Cloud Provider
    aws = {
      source  = "hashicorp/aws"
      version = "5.13"
    }

  }
  # Setting the Terraform version
  required_version = ">= 1.1.0"
}

# Default provider accessing the root account
provider "aws" {
  # Any region can be set here as IAM is a global service
  region = var.region
}