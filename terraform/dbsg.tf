
#create a security group fow DB server 
resource "aws_security_group" "db_sg" {
  vpc_id      = aws_vpc.main.id
  name        = "DB_SG"
  description = "Allow  webserver inbound traffic from ALB"

  # DB allowed port
  ingress {
    # mysql port
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = [aws_security_group.appsg.id]
  }

 egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-SG"
  }
}
