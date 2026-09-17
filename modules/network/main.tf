# ============================================================
# VPC
# ============================================================
# Crea la red privada principal donde estará toda la infraestructura.

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-mean-vpc"
  }
}


# ============================================================
# SUBNET PUBLICA
# ============================================================
# Crea la subred pública para los recursos que requieren acceso a Internet.

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-mean-public-subnet"
  }
}

# ============================================================
# SUBNET PUBLICA 2
# ============================================================
# Crea la segunda subnet publica en otra zona de disponibilidad para el ALB.

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-mean-public-subnet-2"
  }
}


# ============================================================
# SUBNET PRIVADA
# ============================================================
# Crea la subred privada donde estará MongoDB sin IP pública.


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "terraform-mean-private-subnet"
  }
}


# ============================================================
# INTERNET GATEWAY
# ============================================================
# Conecta la VPC con Internet para permitir conectividad de los recursos públicos.

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "terraform-mean-igw"
  }
}


# ============================================================
# ROUTE TABLE PUBLICA
# ============================================================
# Envía el tráfico hacia cualquier IPv4 de Internet mediante el Internet Gateway.

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "terraform-mean-public-rt"
  }
}


# ============================================================
# ASOCIACION SUBNET PUBLICA -> ROUTE TABLE PUBLICA
# ============================================================
# Asocia la subnet pública con la tabla de rutas que utiliza el Internet Gateway.

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
# ============================================================
# ASOCIACION SUBNET PUBLICA 2 -> ROUTE TABLE PUBLICA
# ============================================================
# Asocia la segunda subnet publica con la misma tabla de rutas hacia Internet.

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# ============================================================
# ELASTIC IP PARA NAT GATEWAY
# ============================================================
# Reserva una dirección IP pública fija que utilizará el NAT Gateway.

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-mean-nat-eip"
  }
}


# ============================================================
# NAT GATEWAY
# ============================================================
# Permite que la subnet privada salga a Internet sin quedar accesible desde Internet.

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.this]

  tags = {
    Name = "terraform-mean-nat-gateway"
  }
}


# ============================================================
# ROUTE TABLE PRIVADA
# ============================================================
# Envía el tráfico de salida de la subnet privada a través del NAT Gateway.

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "terraform-mean-private-rt"
  }
}


# ============================================================
# ASOCIACION SUBNET PRIVADA -> ROUTE TABLE PRIVADA
# ============================================================
# Asocia la subnet privada con la tabla de rutas que utiliza el NAT Gateway.

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}