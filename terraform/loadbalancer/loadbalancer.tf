resource "aws_lb" "main" {
  name               = "${var.project}-${var.stage}-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = concat([aws_security_group.main.id], var.additional_security_group_ids)
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  dynamic "access_logs" {
    for_each = var.enable_access_logs == true ? [1] : []
    content {
      bucket  = var.access_logs_bucket
      prefix  = "${var.project}-${var.stage}-lb"
      enabled = true
    }
  }

  tags = local.tags
}

resource "aws_security_group" "main" {
  name        = "${var.project}-${var.stage}-sg"
  description = "Allow every traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({
    Name = "${var.project}-${var.stage}-default-security-group"
  }, local.tags)
}
