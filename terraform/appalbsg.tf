# Creating Security Group int ALB
resource "aws_security_group" "appalbsg" {
  name   = "AppAlbSG"
  vpc_id = aws_vpc.main.id

  # HTTP access from web Tier
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.websg.id]
  }

    # Internet 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "appalb-SG"
  }
}
