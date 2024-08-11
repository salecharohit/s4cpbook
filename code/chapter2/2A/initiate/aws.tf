provider "aws" {
  region = "us-west-2"
}

# Setting and locking the Dependencies to specific versions
terraform {
  required_providers {

    # AWS Cloud Provider
    aws = {
      source  = "hashicorp/aws"
      version = "5.13"
    }

    # Provider to generate random numbers
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

  }
  # Setting the Terraform version
  required_version = ">= 1.1.0"
}
