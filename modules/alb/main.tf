# ============================================================
# APPLICATION LOAD BALANCER
# ============================================================
# Crea un ALB publico distribuido entre las dos subnets publicas.

resource "aws_lb" "this" {
  name               = "terraform-mean-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "terraform-mean-alb"
  }
}


# ============================================================
# TARGET GROUP
# ============================================================
# Define el grupo de destino donde se registrara la instancia de aplicacion.

resource "aws_lb_target_group" "app" {
  name     = "terraform-mean-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


# ============================================================
# REGISTRO DE LA INSTANCIA APP
# ============================================================
# Registra la instancia EC2 de aplicacion dentro del Target Group.

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.app_instance_id
  port             = 80
}


# ============================================================
# LISTENER HTTP
# ============================================================
# Recibe trafico HTTP por el puerto 80 y lo envia al Target Group.

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}