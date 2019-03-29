# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.environment}-exam-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb_sg.id}"]
  subnets            = ["${var.subnet_ids}"]

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Load balancer security group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Environment = "${var.environment}"
    Name = "exam-alb-security-group"
  }
}

resource "aws_alb_target_group" "group" {
  name     = "exam-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/login"
    port = 80
  }
}
resource "aws_alb_listener" "listener_http" {
  depends_on        = ["aws_lb.alb"]
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}