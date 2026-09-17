# ============================================================
# SECURITY GROUP DEL ALB
# ============================================================
# Permite tráfico HTTP desde Internet hacia el Load Balancer.

resource "aws_security_group" "alb" {
  name        = "terraform-mean-alb-sg"
  description = "Security Group para el Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP desde Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir todo el trafico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-mean-alb-sg"
  }
}


# ============================================================
# SECURITY GROUP DE LA APLICACION
# ============================================================
# Permite que solamente el ALB acceda por HTTP a la capa de aplicación.

resource "aws_security_group" "app" {
  name        = "terraform-mean-app-sg"
  description = "Security Group para servidor Nginx y Node.js"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP desde el ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Permitir todo el trafico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-mean-app-sg"
  }
}


# ============================================================
# SECURITY GROUP DE MONGODB
# ============================================================
# Permite MongoDB por el puerto 27017 solamente desde la capa de aplicación.

resource "aws_security_group" "mongo" {
  name        = "terraform-mean-mongo-sg"
  description = "Security Group para MongoDB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MongoDB solamente desde App"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    description = "Permitir todo el trafico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-mean-mongo-sg"
  }
}