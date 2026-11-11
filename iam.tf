# ─────────────────────────────────────────────
# EC2 Instance Profile for Elastic Beanstalk
# ─────────────────────────────────────────────
data "aws_iam_policy_document" "eb_ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eb_ec2" {
  name               = "${var.namespace}-${var.environment}-eb-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.eb_ec2_assume_role.json

  tags = {
    Name = "${var.namespace}-${var.environment}-eb-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "eb_web_tier" {
  role       = aws_iam_role.eb_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "eb_multicontainer_docker" {
  role       = aws_iam_role.eb_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_role_policy_attachment" "ssm_managed" {
  role       = aws_iam_role.eb_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.eb_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Least-privilege: allow reading secrets for this service only
data "aws_iam_policy_document" "eb_ec2_secrets" {
  statement {
    sid    = "ReadServiceSecrets"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      "arn:aws:secretsmanager:${var.region}:*:secret:${var.namespace}/${var.environment}/frontend-app/*"
    ]
  }
}

resource "aws_iam_role_policy" "eb_ec2_secrets" {
  name   = "frontend-app-secrets-access"
  role   = aws_iam_role.eb_ec2.id
  policy = data.aws_iam_policy_document.eb_ec2_secrets.json
}

resource "aws_iam_instance_profile" "eb_ec2" {
  name = "${var.namespace}-${var.environment}-eb-ec2-profile"
  role = aws_iam_role.eb_ec2.name
}

# ─────────────────────────────────────────────
# Elastic Beanstalk Service Role
# ─────────────────────────────────────────────
data "aws_iam_policy_document" "eb_service_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eb_service" {
  name               = "${var.namespace}-${var.environment}-eb-service-role"
  assume_role_policy = data.aws_iam_policy_document.eb_service_assume_role.json

  tags = {
    Name = "${var.namespace}-${var.environment}-eb-service-role"
  }
}

resource "aws_iam_role_policy_attachment" "eb_enhanced_health" {
  role       = aws_iam_role.eb_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "eb_managed_updates" {
  role       = aws_iam_role.eb_service.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}