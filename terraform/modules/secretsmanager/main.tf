resource "aws_secretsmanager_secret" "database_url" {
  name = "/ecs-calc-app/production/DATABASE_URL"
  description = "Production database URL"
  recovery_window_in_days = 0 # for easy cleanup in demo
}

resource "aws_secretsmanager_secret_version" "database_url_val" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = var.database_url
}

resource "aws_secretsmanager_secret" "api_key" {
  name = "/ecs-calc-app/production/API_KEY"
  description = "Production API Key"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "api_key_val" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = var.api_key
}
