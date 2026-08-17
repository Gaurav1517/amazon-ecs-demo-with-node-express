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
