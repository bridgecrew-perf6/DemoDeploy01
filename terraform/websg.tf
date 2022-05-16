#create a security group fow Web server 
resource "aws_security_group" "websg" {
  vpc_id      = aws_vpc.main.id
  name        = "WebSG"
  description = "Allow  web traffic"

  #ingress traffic coming from outside to in 
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.webalbsg.id]
  }
  
    # Internet 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
      Name = "Web-sg"
    }
  }


