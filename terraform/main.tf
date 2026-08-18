module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  igw_name        = var.igw_name
  public_rt_name  = var.public_rt_name
  private_rt_name = var.private_rt_name
  nat_gw_name     = var.nat_gw_name
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.ecr_repo_name
}

module "iam" {
  source = "./modules/iam"
}

resource "random_password" "cf_alb_secret" {
  length  = 32
  special = false
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.sg.alb_sg_id
  shared_secret     = random_password.cf_alb_secret.result
}

module "waf" {
  source = "./modules/waf"
  providers = {
    aws = aws.us_east_1
  }
}

module "route53_acm" {
  source                 = "./modules/route53_acm"
  domain_name            = var.domain_name
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name

  providers = {
    aws = aws.us_east_1
  }
}

module "cloudfront" {
  source              = "./modules/cloudfront"
  alb_dns_name        = module.alb.alb_dns_name
  waf_web_acl_arn     = module.waf.web_acl_arn
  domain_name         = var.domain_name
  acm_certificate_arn = module.route53_acm.acm_certificate_arn
  shared_secret       = random_password.cf_alb_secret.result
}

module "ecs" {
  source             = "./modules/ecs"
  aws_region         = var.aws_region
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
  ecr_repository_url = module.ecr.repository_url

  target_group_arn   = module.alb.target_group_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  tasks_sg_id        = module.sg.tasks_sg_id
}

module "cloudwatch" {
  source                  = "./modules/cloudwatch"
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs.service_name
}

module "oidc" {
  source             = "./modules/oidc"
  github_repo        = var.github_repo
  ecr_repository_arn = module.ecr.repository_arn
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
}
