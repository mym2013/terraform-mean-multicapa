# ============================================================
# OUTPUT VPC ID
# ============================================================
# Expone el ID de la VPC para que otros módulos puedan utilizarla.

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.this.id
}


# ============================================================
# OUTPUT SUBNET PUBLICA ID
# ============================================================
# Expone el ID de la subnet pública para recursos como EC2 App y ALB.

output "public_subnet_id" {
  description = "ID de la subnet publica"
  value       = aws_subnet.public.id
}


# ============================================================
# OUTPUT SUBNET PRIVADA ID
# ============================================================
# Expone el ID de la subnet privada donde se desplegará MongoDB.

output "private_subnet_id" {
  description = "ID de la subnet privada"
  value       = aws_subnet.private.id
}


# ============================================================
# OUTPUT IP PUBLICA NAT GATEWAY
# ============================================================
# Expone la Elastic IP utilizada por el NAT Gateway.
# Este dato es solicitado explícitamente por la rúbrica de la actividad.

output "nat_public_ip" {
  description = "IP publica del NAT Gateway"
  value       = aws_eip.nat.public_ip
}

# ============================================================
# OUTPUT SUBNET PUBLICA 2 ID
# ============================================================
# Expone el ID de la segunda subnet publica para utilizarla en el ALB.

output "public_subnet_2_id" {
  description = "ID de la segunda subnet publica"
  value       = aws_subnet.public_2.id
}