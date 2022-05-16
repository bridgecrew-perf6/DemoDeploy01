cluster_name = "dev"

# AWS CLI config profile
aws_profile = "default"
aws_region  = "us-east-1"


vpc_cidr                 = "10.4.0.0/16"
vpc_az1                  = "us-east-1a"
vpc_az2                  = "us-east-1b"
ec2_type                 = "t2.micro"
vpc_public_subnet1_cidr  = "10.4.1.0/24"
vpc_public_subnet2_cidr  = "10.4.2.0/24"
vpc_private_subnet1_cidr = "10.4.3.0/24"
vpc_private_subnet2_cidr = "10.4.4.0/24"
vpc_db_subnet1_cidr      = "10.4.5.0/24"
vpc_db_subnet2_cidr      = "10.4.6.0/24"
