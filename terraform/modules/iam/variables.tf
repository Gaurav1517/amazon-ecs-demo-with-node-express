variable "execution_role_name" {
  description = "The name of the ECS Task Execution Role"
  type        = string
  default     = "ecs-calc-execution-role"
}

variable "task_role_name" {
  description = "The name of the ECS Task Role"
  type        = string
  default     = "ecs-calc-task-role"
}
