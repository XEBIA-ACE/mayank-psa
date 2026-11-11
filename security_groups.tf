# ─────────────────────────────────────────────
# ALB Security Group  (public-facing)
# ─────────────────────────────────────────────
resource "aws_security_group" "alb" {
  name        = "${var.namespace}-${var.environment}-alb-sg"
  description = "Allow inbound HTTPS (and HTTP redirect) to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from internet (redirect to HTTPS)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-${var.environment}-alb-sg"
  }
}

# ─────────────────────────────────────────────
# EC2 / Beanstalk Instance Security Group
# ─────────────────────────────────────────────
resource "aws_security_group" "eb_instances" {
  name        = "${var.namespace}-${var.environment}-eb-instances-sg"
  description = "Allow traffic from ALB to Beanstalk EC2 instances only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "App port from ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all outbound (NAT)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-${var.environment}-eb-instances-sg"
  }
}