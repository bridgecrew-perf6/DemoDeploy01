# Creating internal LoadBalancer for application tier
resource "aws_lb" "internal-elb" {
  name               = "Internal-Lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.appalbsg.id]
  subnets            = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

}

resource "aws_lb_target_group" "app-target-group" {
  name     = "alb-tg-int"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  tags = {
    name = "TaragetGroupInternal"
  }
}

resource "aws_lb_listener" "app-listener-elb" {
  load_balancer_arn = aws_lb.internal-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-target-group.arn
  }
}

