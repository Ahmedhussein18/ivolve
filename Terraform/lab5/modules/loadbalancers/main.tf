

############## Public Load Balancer #############

resource "aws_lb" "public_lb" {
  name               = "${var.project_name}-public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.public_lb_sg
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-public-lb"
  }
}

resource "aws_lb_target_group" "nginx_tg" {
  name     = "${var.project_name}-nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }

  tags = {
    Name = "${var.project_name}-nginx-tg"
  }
}

resource "aws_lb_target_group_attachment" "nginx_attachment" {
  count            = length(var.nginx_instance_ids)
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = var.nginx_instance_ids[count.index]
  port             = 80
}

resource "aws_lb_listener" "public_lb_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}

############## Internal Load Balancer ##############



resource "aws_lb" "internal_lb" {
  name               = "${var.project_name}-internal-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.internal_lb_sg
  subnets            = var.private_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-internal-lb"
  }
}


resource "aws_lb_target_group" "httpd_tg" {
  name     = "${var.project_name}-httpd-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }

  tags = {
    Name = "${var.project_name}-httpd-tg"
  }
}

resource "aws_lb_target_group_attachment" "httpd_attachment" {
  count            = length(var.httpd_instance_ids)
  target_group_arn = aws_lb_target_group.httpd_tg.arn
  target_id        = var.httpd_instance_ids[count.index]
  port             = 80
}


resource "aws_lb_listener" "internal_lb_listener" {
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.httpd_tg.arn
  }
}





