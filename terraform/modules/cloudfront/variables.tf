variable "alb_dns_name" {
  description = "The DNS name of the ALB to use as the origin"
  type        = string
}

variable "waf_web_acl_arn" {
  description = "The ARN of the WAF Web ACL to associate with the distribution"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the distribution"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use"
  type        = string
}

variable "shared_secret" {
  description = "The shared secret for CloudFront to send to the ALB"
  type        = string
}
