# ============================================================
# OUTPUT ID DE LA INSTANCIA APP
# ============================================================
# Expone el ID de la instancia EC2 de la capa de aplicacion.

output "instance_id" {
  description = "ID de la instancia EC2 de aplicacion"
  value       = aws_instance.app.id
}


# ============================================================
# OUTPUT IP PUBLICA DE LA APLICACION
# ============================================================
# Expone la direccion IP publica de la instancia de aplicacion.

output "public_ip" {
  description = "IP publica de la instancia de aplicacion"
  value       = aws_instance.app.public_ip
}


# ============================================================
# OUTPUT IP PRIVADA DE LA APLICACION
# ============================================================
# Expone la direccion IP privada de la instancia de aplicacion.

output "private_ip" {
  description = "IP privada de la instancia de aplicacion"
  value       = aws_instance.app.private_ip
}