resource "aws_security_group" "alb" {
  name        = "ecs-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs-alb-sg"
  }
}

resource "aws_security_group" "tasks" {
  name        = "ecs-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs-tasks-sg"
  }
}

# Note: The data source `aws_ec2_managed_prefix_list` was failing due to 
# missing IAM permissions (ec2:GetManagedPrefixListEntries) on the node-express-app user.
# The ID `pl-9aa247f3` is the static AWS-managed CloudFront prefix list ID for ap-south-1.

# ALB Inbound: HTTP (80) restricted to CloudFront Origin-Facing IP ranges
resource "aws_security_group_rule" "alb_cloudfront_http_in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  prefix_list_ids   = ["pl-9aa247f3"]
  security_group_id = aws_security_group.alb.id
}

# ALB Outbound: Custom TCP port 3000 pointing directly to ecs-tasks-sg
resource "aws_security_group_rule" "alb_to_tasks_out" {
  type                     = "egress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tasks.id
  security_group_id        = aws_security_group.alb.id
}

# ECS Security Group Inbound: Custom TCP port 3000 restricted only to traffic originating from ecs-alb-sg
resource "aws_security_group_rule" "tasks_from_alb_in" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.tasks.id
}

# ECS Security Group Outbound: All outbound traffic (0.0.0.0/0)
resource "aws_security_group_rule" "tasks_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tasks.id
}
