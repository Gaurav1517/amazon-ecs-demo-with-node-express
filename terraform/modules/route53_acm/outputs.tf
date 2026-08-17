
output "acm_certificate_arn" {
  description = "The ARN of the validated ACM Certificate"
  value       = aws_acm_certificate_validation.cert.certificate_arn
}
