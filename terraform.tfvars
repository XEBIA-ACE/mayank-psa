# ── Adjust these values for your deployment ──────────────────────────────────

region      = "us-east-1"
environment = "dev"
namespace   = "ace"

# Node.js platform — run the following to list available stacks:
#   aws elasticbeanstalk list-available-solution-stacks --query "SolutionStacks" | grep -i node
nodejs_version = "64bit Amazon Linux 2023 v6.5.1 running Node.js 22"

instance_type  = "t3.small"
autoscale_min  = 1
autoscale_max  = 2
app_port       = 8080
healthcheck_url = "/health"
node_env       = "development"

# VPC
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

logs_retention_days = 30

# Set your ACM certificate ARN to enable HTTPS (leave empty for dev HTTP-only)
certificate_arn = ""