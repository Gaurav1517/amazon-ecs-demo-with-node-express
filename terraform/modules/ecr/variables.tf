variable "repo_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "untagged_image_retention_days" {
  description = "Number of days to retain untagged images before deletion"
  type        = number
  default     = 14
}
