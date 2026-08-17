output "alb_sg_id" {
  description = "The ID of the ALB Security Group"
  value       = aws_security_group.alb.id
}

output "tasks_sg_id" {
  description = "The ID of the ECS Tasks Security Group"
  value       = aws_security_group.tasks.id
}
