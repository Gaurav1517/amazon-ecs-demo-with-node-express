variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the ECS task role"
  type        = string
}

variable "ecr_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the ALB Target Group"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets where tasks will run"
  type        = list(string)
}

variable "tasks_sg_id" {
  description = "The ID of the security group for the ECS tasks"
  type        = string
}

variable "database_url_arn" {
  description = "ARN of the DATABASE_URL SSM Parameter"
  type        = string
}

variable "api_key_arn" {
  description = "ARN of the API_KEY SSM Parameter"
  type        = string
}
