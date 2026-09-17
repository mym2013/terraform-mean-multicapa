# ============================================================
# OUTPUT DNS DEL ALB
# ============================================================
# Expone el nombre DNS publico utilizado para acceder a la aplicacion.

output "dns_name" {
  description = "DNS publico del Application Load Balancer"
  value       = aws_lb.this.dns_name
}