terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3.0"
    }
  }

 # required_version = ">= 1.0.0"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Used to get access to the effective account and user that Terraform
data "aws_caller_identity" "current" {}

#create private key which can be use login to webserver 
resource "tls_private_key" "Web-Key" {
  algorithm = "RSA"
}
#save public key from geneterted key
resource "aws_key_pair" "App_instance-Key" {
  key_name   = "Web-Key"
  public_key = tls_private_key.Web-Key.public_key_openssh
}
#save to key to your local system
resource "local_file" "Web-Key" {
  content  = tls_private_key.Web-Key.private_key_pem
  filename = "Web-Key.pem"
}

