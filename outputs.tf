output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs (ALB)"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs (EC2 instances)"
  value       = aws_subnet.private[*].id
}

output "eb_application_name" {
  description = "Elastic Beanstalk application name"
  value       = module.eb_application.elastic_beanstalk_application_name
}

output "eb_environment_name" {
  description = "Elastic Beanstalk environment name"
  value       = module.eb_environment.name
}

output "eb_environment_endpoint" {
  description = "Elastic Beanstalk environment CNAME / endpoint URL"
  value       = module.eb_environment.endpoint
}

output "eb_environment_id" {
  description = "Elastic Beanstalk environment ID"
  value       = module.eb_environment.id
}

output "eb_ec2_instance_profile" {
  description = "EC2 instance profile name"
  value       = aws_iam_instance_profile.eb_ec2.name
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}

output "eb_instances_security_group_id" {
  description = "Beanstalk EC2 instances security group ID"
  value       = aws_security_group.eb_instances.id
}

output "cloudwatch_log_group_app" {
  description = "CloudWatch log group for application logs"
  value       = aws_cloudwatch_log_group.app.name
}

output "s3_artifacts_bucket" {
  description = "S3 bucket for Elastic Beanstalk app version artifacts"
  value       = aws_s3_bucket.eb_artifacts.bucket
}