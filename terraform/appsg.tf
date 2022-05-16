# Creating Security Group 
resource "aws_security_group" "appsg" {
 name = "appsg"
 vpc_id = aws_vpc.main.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.appalbsg.id]
  }

  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "App-sg"
  }
}