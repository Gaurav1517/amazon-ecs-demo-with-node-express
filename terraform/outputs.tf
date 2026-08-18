output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "alb_sg_id" {
  description = "The ID of the ALB Security Group"
  value       = module.sg.alb_sg_id
}

output "tasks_sg_id" {
  description = "The ID of the ECS Tasks Security Group"
  value       = module.sg.tasks_sg_id
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecs_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  value       = module.iam.execution_role_arn
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS Task Role"
  value       = module.iam.task_role_arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "waf_web_acl_arn" {
  description = "The ARN of the WAF Web ACL"
  value       = module.waf.web_acl_arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront Distribution"
  value       = module.cloudfront.cloudfront_domain_name
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}
output "github_actions_role_arn" {
  description = "The ARN of the IAM role for GitHub Actions to assume"
  value       = module.oidc.github_actions_role_arn
}
