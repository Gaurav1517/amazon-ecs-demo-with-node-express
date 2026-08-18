output "app_port_arn" {
  value       = aws_ssm_parameter.app_port.arn
  description = "ARN of the APP_PORT SSM Parameter"
}

output "node_env_arn" {
  value       = aws_ssm_parameter.node_env.arn
  description = "ARN of the NODE_ENV SSM Parameter"
}
