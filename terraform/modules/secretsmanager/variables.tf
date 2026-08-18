variable "database_url" {
  description = "The production database URL"
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "The production API key"
  type        = string
  sensitive   = true
}
