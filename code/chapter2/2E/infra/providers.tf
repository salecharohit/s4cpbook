# Setting and locking the Dependencies to specific versions
terraform {
  required_providers {

    # AWS Cloud Provider
    aws = {
      source  = "hashicorp/aws"
      version = "4.54"
    }

    # TLS provider to generate SSH Keys
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

    # Provider to generate random numbers
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    # Provider to interact with the local system
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    # Provider to interact with kubernetes clusters
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.19.0"
    }

    # Provider to execute kubectl utility through terraform
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    # Provider to execute kubectl utility through terraform
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }

  }
  # Setting the Terraform version
  required_version = ">= 1.1.0"
}

# Feeding the AWS providers with the data it needs
locals {
  assume_role_arn = "arn:aws:iam::${var.assume_role_account_id}:role/Administrator"
}
provider "aws" {

  assume_role {
    role_arn = local.assume_role_arn

  }
  region = var.region

}