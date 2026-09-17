# ============================================================
# OUTPUT ID DE LA INSTANCIA MONGODB
# ============================================================
# Expone el ID de la instancia EC2 que ejecuta MongoDB.

output "instance_id" {
  description = "ID de la instancia EC2 de MongoDB"
  value       = aws_instance.mongo.id
}


# ============================================================
# OUTPUT IP PRIVADA DE MONGODB
# ============================================================
# Expone la IP privada utilizada por MongoDB dentro de la VPC.

output "private_ip" {
  description = "IP privada de la instancia MongoDB"
  value       = aws_instance.mongo.private_ip
}


# ============================================================
# OUTPUT IP PUBLICA DE MONGODB
# ============================================================
# Expone la IP publica de MongoDB, que sera null porque la instancia es privada.

output "public_ip" {
  description = "IP publica de la instancia MongoDB"
  value       = aws_instance.mongo.public_ip
}
