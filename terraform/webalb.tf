# Creating external LoadBalancer for Web tier
resource "aws_alb" "external-elb" {
  name               = "external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webalbsg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}

resource "aws_alb_target_group" "web-target-group" {
  name     = "alb-tg-ex"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_alb_listener" "web-listener-elb" {
  load_balancer_arn = aws_alb.external-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web-target-group.arn
  }
}
