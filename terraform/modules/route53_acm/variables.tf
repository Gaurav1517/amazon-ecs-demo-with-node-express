variable "domain_name" {
  description = "The root domain name (e.g. amyxjack02.shop)"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution to alias to"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "The hosted zone ID of the CloudFront distribution"
  type        = string
  default     = "Z2FDTNDATAQYW2" # AWS statically uses this for all CloudFront distributions
}
