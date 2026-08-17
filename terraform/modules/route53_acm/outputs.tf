output "nameservers" {
  description = "The nameservers for the Route 53 Hosted Zone (Copy these to Hostinger)"
  value       = aws_route53_zone.public.name_servers
}

output "acm_certificate_arn" {
  description = "The ARN of the validated ACM Certificate"
  value       = aws_acm_certificate_validation.cert.certificate_arn
}
