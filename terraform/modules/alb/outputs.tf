output "target_group_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.this.arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix of the ALB (used for CloudWatch alarms)"
  value       = aws_lb.this.arn_suffix
}

output "target_group_arn_suffix" {
  description = "The ARN suffix of the Target Group (used for CloudWatch alarms)"
  value       = aws_lb_target_group.this.arn_suffix
}
