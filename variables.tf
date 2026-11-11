variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "namespace" {
  description = "Namespace / org abbreviation for resource naming"
  type        = string
  default     = "ace"
}

variable "nodejs_version" {
  description = "Node.js platform version on Elastic Beanstalk"
  type        = string
  # Run: aws elasticbeanstalk list-available-solution-stacks | grep -i node
  default     = "64bit Amazon Linux 2023 v6.5.1 running Node.js 22"
}

variable "instance_type" {
  description = "EC2 instance type for Beanstalk instances"
  type        = string
  default     = "t3.small"
}

variable "autoscale_min" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 1
}

variable "autoscale_max" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 2
}

variable "app_port" {
  description = "Port the Node.js application listens on"
  type        = number
  default     = 8080
}

variable "healthcheck_url" {
  description = "HTTP path for ELB health checks"
  type        = string
  default     = "/health"
}

variable "node_env" {
  description = "NODE_ENV value passed to the application"
  type        = string
  default     = "development"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (EC2 instances)"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "logs_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS. Leave empty to use HTTP only (dev)."
  type        = string
  default     = ""
}