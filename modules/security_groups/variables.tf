# ============================================================
# VPC ID
# ============================================================
# Recibe el ID de la VPC donde se crearán los Security Groups.

variable "vpc_id" {
  description = "ID de la VPC principal"
  type        = string
}