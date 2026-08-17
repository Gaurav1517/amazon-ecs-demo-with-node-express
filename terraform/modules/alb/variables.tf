variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "The security group ID for the ALB"
  type        = string
}

variable "shared_secret" {
  description = "The shared secret for CloudFront to send to the ALB"
  type        = string
}

variable "tg_name" {
  description = "The name of the target group"
  type        = string
  default     = "ecs-calc-tg"
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "ecs-calc-alb"
}
