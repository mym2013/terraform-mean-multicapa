# ============================================================
# OUTPUT SECURITY GROUP DEL ALB
# ============================================================
# Expone el ID del Security Group del Load Balancer.

output "alb_sg_id" {
  description = "ID del Security Group del ALB"
  value       = aws_security_group.alb.id
}


# ============================================================
# OUTPUT SECURITY GROUP DE LA APLICACION
# ============================================================
# Expone el ID del Security Group utilizado por la capa de aplicación.

output "app_sg_id" {
  description = "ID del Security Group de la aplicacion"
  value       = aws_security_group.app.id
}


# ============================================================
# OUTPUT SECURITY GROUP DE MONGODB
# ============================================================
# Expone el ID del Security Group utilizado por MongoDB.

output "mongo_sg_id" {
  description = "ID del Security Group de MongoDB"
  value       = aws_security_group.mongo.id
}