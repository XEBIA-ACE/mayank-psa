# ─────────────────────────────────────────────
# Elastic Beanstalk Application
# ─────────────────────────────────────────────
module "eb_application" {
  source  = "cloudposse/elastic-beanstalk-application/aws"
  version = "0.13.0"

  namespace   = var.namespace
  stage       = var.environment
  name        = "frontend-app"
  description = "Node.js frontend application"

  appversion_lifecycle_max_count          = 50
  appversion_lifecycle_delete_source_from_s3 = true
  create_lifecycle_service_role           = true
  prefer_legacy_service_policy            = false

  tags = {
    Service = "frontend-app"
  }
}

# ─────────────────────────────────────────────
# Elastic Beanstalk Environment
# ─────────────────────────────────────────────
module "eb_environment" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  version = "0.56.0"

  namespace   = var.namespace
  stage       = var.environment
  name        = "frontend-app"
  description = "Node.js frontend app environment"

  region = var.region

  # Application
  elastic_beanstalk_application_name = module.eb_application.elastic_beanstalk_application_name
  solution_stack_name                = var.nodejs_version

  # Network
  vpc_id              = aws_vpc.main.id
  application_subnets = aws_subnet.private[*].id
  loadbalancer_subnets = aws_subnet.public[*].id

  # Load Balancer
  loadbalancer_type                        = "application"
  http_listener_enabled                    = true
  loadbalancer_redirect_http_to_https      = var.certificate_arn != "" ? true : false
  loadbalancer_certificate_arn             = var.certificate_arn
  loadbalancer_ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  enable_loadbalancer_logs                 = true
  loadbalancer_security_groups             = [aws_security_group.alb.id]
  associated_security_group_ids            = [aws_security_group.eb_instances.id]

  # Compute
  instance_type         = var.instance_type
  autoscale_min         = var.autoscale_min
  autoscale_max         = var.autoscale_max
  autoscale_measure_name = "CPUUtilization"
  autoscale_lower_bound = 20
  autoscale_upper_bound = 70
  associate_public_ip_address = false

  # Health
  healthcheck_url                    = var.healthcheck_url
  enhanced_reporting_enabled         = true
  health_streaming_enabled           = true
  health_streaming_retention_in_days = var.logs_retention_days

  # Deployment
  deployment_policy    = "Rolling"
  rolling_update_type  = "Health"
  updating_max_batch   = 1
  updating_min_in_service = 1

  # Logging
  enable_stream_logs          = true
  logs_retention_in_days      = var.logs_retention_days
  logs_delete_on_terminate    = false
  enable_log_publication_control = true

  # Managed updates
  managed_actions_enabled = true
  preferred_start_time    = "Sun:03:00"
  update_level            = "minor"
  prefer_legacy_service_policy = false

  # Environment variables
  env_vars = {
    NODE_ENV = var.node_env
    PORT     = tostring(var.app_port)
  }

  # Additional settings
  additional_settings = [
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "IamInstanceProfile"
      value     = aws_iam_instance_profile.eb_ec2.name
    },
    {
      namespace = "aws:elasticbeanstalk:environment"
      name      = "ServiceRole"
      value     = aws_iam_role.eb_service.arn
    },
    {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "StreamLogs"
      value     = "true"
    },
    {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "RetentionInDays"
      value     = tostring(var.logs_retention_days)
    },
    {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
      name      = "HealthStreamingEnabled"
      value     = "true"
    },
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "RootVolumeType"
      value     = "gp3"
    },
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "RootVolumeSize"
      value     = "20"
    },
    {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AWS_REGION"
      value     = var.region
    }
  ]

  tags = {
    Service = "frontend-app"
  }

  depends_on = [
    aws_iam_instance_profile.eb_ec2,
    aws_iam_role.eb_service,
    aws_security_group.alb,
    aws_security_group.eb_instances,
  ]
}