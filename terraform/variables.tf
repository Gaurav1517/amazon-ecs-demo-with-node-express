variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "node-express"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "A list of maps describing public subnets (cidr, name, az)"
  type = list(object({
    cidr = string
    name = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "A list of maps describing private subnets (cidr, name, az)"
  type = list(object({
    cidr = string
    name = string
    az   = string
  }))
}

variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string
}

variable "public_rt_name" {
  description = "The name of the Public Route Table"
  type        = string
}

variable "private_rt_name" {
  description = "The name of the Private Route Table"
  type        = string
}

variable "nat_gw_name" {
  description = "The name of the NAT Gateway"
  type        = string
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the application"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository to allow for OIDC (e.g., Gaurav1517/amazon-ecs-demo-with-node-express)"
  type        = string
}
