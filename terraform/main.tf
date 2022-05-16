# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Demo VPC"
  }
}

# Create Web Public Subnet
resource "aws_subnet" "web-subnet-1" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Web-1a"
  }
}
resource "aws_instance" "web" {
  instance_type = var.instance_type
  ami           = var.aws_ec2_ami
  vpc_id        = aws_vpc.my-vpc.id
subnet_id = aws_subnet.web-subnet-1.id
  tags = {
    "Name" = "aws-ec2-demo"
  }
}
