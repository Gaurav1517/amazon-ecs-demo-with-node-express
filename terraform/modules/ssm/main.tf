resource "aws_ssm_parameter" "app_port" {
  name  = "/ecs-calc-app/production/APP_PORT"
  type  = "SecureString"
  value = "3000"

  tags = {
    Name        = "AppPort"
    Environment = "production"
  }
}

resource "aws_ssm_parameter" "node_env" {
  name  = "/ecs-calc-app/production/NODE_ENV"
  type  = "SecureString"
  value = "production"

  tags = {
    Name        = "NodeEnv"
    Environment = "production"
  }
}
