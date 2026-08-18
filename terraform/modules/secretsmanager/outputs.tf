output "database_url_arn" {
  value       = aws_secretsmanager_secret.database_url.arn
  description = "ARN of the DATABASE_URL Secret"
}

output "api_key_arn" {
  value       = aws_secretsmanager_secret.api_key.arn
  description = "ARN of the API_KEY Secret"
}
