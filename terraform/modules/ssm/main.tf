resource "aws_ssm_parameter" "app_port" {
  name  = "/ecs-calc-app/production/APP_PORT"
  type  = "SecureString"
  value = var.app_port

  tags = {
    Name        = "AppPort"
    Environment = "production"
  }
}

resource "aws_ssm_parameter" "node_env" {
  name  = "/ecs-calc-app/production/NODE_ENV"
  type  = "SecureString"
  value = var.node_env

  tags = {
    Name        = "NodeEnv"
    Environment = "production"
  }
}
