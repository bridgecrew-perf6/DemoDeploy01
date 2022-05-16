

#Public Subnet Webserver Launch Template
resource "aws_launch_template" "web_launch_template" {
  name                   = "web-launch-template"
  image_id               = "ami-00e87074e52e6c9f9"
  instance_type          = var.ec2_type
  vpc_security_group_ids = [aws_security_group.websg.id]
  key_name               = "Web-Key"
  user_data = (base64encode(<<EOF
#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>***Web-Server Test***</h1>" >> /var/www/html/index.html
EOF
  ))
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "WEB-SERVER"
    }
  }

}

resource "aws_autoscaling_group" "asgweb" {
  vpc_zone_identifier       = ["${aws_subnet.public_subnet1.id}", "${aws_subnet.public_subnet2.id}"]
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = ["${aws_alb_target_group.web-target-group.arn}"]

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

}

#Privite Subnet Webserver Launch Template
resource "aws_launch_template" "app_launch_template" {
  name                   = "app-launch-template"
  image_id               = "ami-00e87074e52e6c9f9"
  instance_type          = var.ec2_type
  vpc_security_group_ids = [aws_security_group.appsg.id]
  key_name               = "Web-Key"
  user_data = (base64encode(<<EOF
#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>***App-Server Test***<br>BigBoss</h1>" >> /var/www/html/index.html
EOF
  ))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "APP-SERVER"
    }
  }
}

resource "aws_autoscaling_group" "asgapp" {
  vpc_zone_identifier       = ["${aws_subnet.private_subnet1.id}", "${aws_subnet.private_subnet2.id}"]
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = ["${aws_lb_target_group.app-target-group.arn}"]

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }


}
