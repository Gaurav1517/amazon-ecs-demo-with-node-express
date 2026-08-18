output "database_url_arn" {
  value       = aws_ssm_parameter.database_url.arn
  description = "ARN of the DATABASE_URL SSM Parameter"
}

output "api_key_arn" {
  value       = aws_ssm_parameter.api_key.arn
  description = "ARN of the API_KEY SSM Parameter"
}
