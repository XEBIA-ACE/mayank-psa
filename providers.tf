terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.72.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }

  backend "s3" {
    bucket         = "tfstate-frontend-app-b6428722"
    key            = "frontend-app/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock-frontend-app"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      ManagedBy   = "ace"
      Environment = var.environment
      Project     = "b6428722-be96-4a6c-8577-b51b2a852347"
      Service     = "frontend-app"
    }
  }
}