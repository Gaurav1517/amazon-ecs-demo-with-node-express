variable "github_repo" {
  description = "The GitHub repository to allow for OIDC (e.g., Gaurav1517/amazon-ecs-demo-with-node-express)"
  type        = string
}

variable "ecr_repository_arn" {
  description = "The ARN of the ECR repository"
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
