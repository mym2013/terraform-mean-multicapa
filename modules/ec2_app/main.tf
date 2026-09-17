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
# INSTANCIA EC2 DE LA APLICACION
# ============================================================
# Crea el servidor de aplicacion dentro de la subnet publica.

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  associate_public_ip_address = true


  # ============================================================
  # CONFIGURACION NGINX + NODE.JS
  # ============================================================
  # Instala automaticamente Nginx y Node.js al iniciar la instancia.

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y nginx nodejs npm

              mkdir -p /opt/nodeapp

              cat > /opt/nodeapp/app.js <<'APP'
              const http = require('http');

              const server = http.createServer((req, res) => {
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.end('<h1>Aplicacion Node.js desplegada con Terraform</h1>');
              });

              server.listen(3000, '127.0.0.1');
              APP

              cat > /etc/systemd/system/nodeapp.service <<'SERVICE'
              [Unit]
              Description=Aplicacion Node.js
              After=network.target

              [Service]
              ExecStart=/usr/bin/node /opt/nodeapp/app.js
              Restart=always
              User=ubuntu

              [Install]
              WantedBy=multi-user.target
              SERVICE

              systemctl daemon-reload
              systemctl enable --now nodeapp

              cat > /etc/nginx/sites-available/default <<'NGINX'
              server {
                  listen 80 default_server;
                  listen [::]:80 default_server;

                  location / {
                      proxy_pass http://127.0.0.1:3000;
                      proxy_http_version 1.1;
                      proxy_set_header Host $host;
                      proxy_set_header X-Real-IP $remote_addr;
                  }
              }
              NGINX

              nginx -t
              systemctl restart nginx
              EOF


  # ============================================================
  # ETIQUETA DE LA INSTANCIA
  # ============================================================
  # Asigna un nombre identificable a la instancia EC2.

  tags = {
    Name = "terraform-mean-app"
  }
}