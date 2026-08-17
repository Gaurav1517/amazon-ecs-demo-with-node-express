output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront Distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront Distribution"
  value       = aws_cloudfront_distribution.this.id
}
