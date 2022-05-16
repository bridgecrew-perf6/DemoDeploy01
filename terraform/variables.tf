variable "cluster_name" {
  description = "The name to give to this environment. Will be used for naming various resources."
  type        = string
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
}

variable "aws_region" {
  description = "AWS region to use"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_az1" {
  description = "The AZ where *-subnet1 will reside"
  type        = string
}

variable "vpc_az2" {
  description = "The AZ where *-subnet2 will reside"
  type        = string
}

variable "ec2_type" {
  description = "ec2 instance type"
  type        = string
}

variable "vpc_public_subnet1_cidr" {
  description = "The cidr block to use for public-subnet1"
  type        = string
}

variable "vpc_public_subnet2_cidr" {
  description = "The cidr block to use for public-subnet2"
  type        = string
}

variable "vpc_private_subnet1_cidr" {
  description = "The cidr block to use for private-subnet1"
  type        = string
}

variable "vpc_private_subnet2_cidr" {
  description = "The cidr block to use for private-subnet2"
  type        = string
}

variable "vpc_db_subnet1_cidr" {
  description = "The cidr block to use for private-subnet1"
  type        = string
}

variable "vpc_db_subnet2_cidr" {
  description = "The cidr block to use for private-subnet2"
  type        = string
}
