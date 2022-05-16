output "cluster_name" {
  value = var.cluster_name
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_profile" {
  value = var.aws_profile
}

output "aws_region" {
  value = var.aws_region
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_alb.external-elb.dns_name
}

