resource "aws_ssm_parameter" "database_url" {
  name  = "/ecs-calc-app/production/DATABASE_URL"
  type  = "SecureString"
  value = "postgres://dummyuser:dummypassword@mydb.example.com:5432/proddb"

  tags = {
    Name        = "DatabaseURL"
    Environment = "production"
  }
}

resource "aws_ssm_parameter" "api_key" {
  name  = "/ecs-calc-app/production/API_KEY"
  type  = "SecureString"
  value = "dummy-api-key-12345"

  tags = {
    Name        = "APIKey"
    Environment = "production"
  }
}
