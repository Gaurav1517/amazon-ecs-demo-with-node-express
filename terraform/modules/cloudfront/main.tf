resource "aws_cloudfront_distribution" "this" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"
  web_acl_id      = var.waf_web_acl_arn

  aliases = [var.domain_name]

  origin {
    domain_name = var.alb_dns_name
    origin_id   = "ecs-calc-alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "X-Shared-Secret"
      value = var.shared_secret
    }
  }

  default_cache_behavior {
    target_origin_id       = "ecs-calc-alb-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]

    # Managed Policy: CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

    # Optional: If you want to forward all headers, cookies, query strings (Managed Policy: AllViewer)
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "ecs-calc-cloudfront"
  }
}
