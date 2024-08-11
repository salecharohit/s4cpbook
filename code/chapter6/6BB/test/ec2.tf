terraform {
  required_providers {
    # AWS Cloud Provider
    aws = {
      source  = "hashicorp/aws"
      version = "4.54"
    }
  }

  required_version = ">= 1.1.0"

}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "dummy_opa" {
  ami           = "ami-01e436b65d641478d"
  instance_type = "t3.micro"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
  }

}

resource "aws_instance" "dummy_opa_1" {
  ami           = "ami-01e436b65d641478d"
  instance_type = "t3.micro"

}

resource "aws_instance" "dummy_opa_2" {
  ami           = "ami-01e436b65d641478d"
  instance_type = "t3.micro"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
  }

}

