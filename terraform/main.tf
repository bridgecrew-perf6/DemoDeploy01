
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC"
  }
}
resource "aws_instance" "web" {
  instance_type = var.instance_type
  ami           = var.aws_ec2_ami

  tags = {
    "Name" = "aws-ec2-demo"
  }
}