# ─────────────────────────────────────────────
# CloudWatch Log Group for application logs
# ─────────────────────────────────────────────
resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/elasticbeanstalk/${var.namespace}-${var.environment}-frontend-app/app"
  retention_in_days = var.logs_retention_days

  tags = {
    Name = "${var.namespace}-${var.environment}-frontend-app-logs"
  }
}

resource "aws_cloudwatch_log_group" "eb_health" {
  name              = "/aws/elasticbeanstalk/${var.namespace}-${var.environment}-frontend-app/health"
  retention_in_days = var.logs_retention_days

  tags = {
    Name = "${var.namespace}-${var.environment}-frontend-app-health-logs"
  }
}

# ─────────────────────────────────────────────
# CloudWatch Alarms
# ─────────────────────────────────────────────
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.namespace}-${var.environment}-frontend-app-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU utilization > 80% for 4 minutes"
  treat_missing_data  = "notBreaching"

  dimensions = {
    AutoScalingGroupName = module.eb_environment.autoscaling_groups[0]
  }

  tags = {
    Name = "${var.namespace}-${var.environment}-frontend-app-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "unhealthy_hosts" {
  alarm_name          = "${var.namespace}-${var.environment}-frontend-app-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "One or more Beanstalk instances are unhealthy"
  treat_missing_data  = "notBreaching"

  tags = {
    Name = "${var.namespace}-${var.environment}-frontend-app-unhealthy-hosts"
  }
}