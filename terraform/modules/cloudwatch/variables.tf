variable "alb_arn_suffix" {
  description = "The ARN suffix of the ALB"
  type        = string
}

variable "target_group_arn_suffix" {
  description = "The ARN suffix of the Target Group"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}
