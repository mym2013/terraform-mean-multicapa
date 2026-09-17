# ============================================================
# AMI UBUNTU
# ============================================================
# Busca automaticamente la imagen Ubuntu 24.04 LTS mas reciente disponible.

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# ============================================================
# INSTANCIA EC2 DE MONGODB
# ============================================================
# Crea el servidor MongoDB dentro de la subnet privada.

resource "aws_instance" "mongo" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = false


  # ============================================================
  # CONFIGURACION DE MONGODB
  # ============================================================
  # Instala MongoDB automaticamente al iniciar la instancia.

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y gnupg curl

              curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc \
                | gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg

              echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" \
                > /etc/apt/sources.list.d/mongodb-org-8.0.list

              apt-get update -y
              apt-get install -y mongodb-org

              sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

              systemctl enable mongod
              systemctl restart mongod
              EOF


  # ============================================================
  # ETIQUETA DE LA INSTANCIA
  # ============================================================
  # Asigna un nombre identificable a la instancia EC2 de MongoDB.

  tags = {
    Name = "terraform-mean-mongo"
  }
}
