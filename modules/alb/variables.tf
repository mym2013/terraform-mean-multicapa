# ============================================================
# VPC ID
# ============================================================
# Recibe el ID de la VPC donde se creara el Target Group.

variable "vpc_id" {
  description = "ID de la VPC principal"
  type        = string
}


# ============================================================
# SUBNETS PUBLICAS
# ============================================================
# Recibe las dos subnets publicas utilizadas por el ALB.

variable "public_subnet_ids" {
  description = "IDs de las subnets publicas para el ALB"
  type        = list(string)
}


# ============================================================
# SECURITY GROUP DEL ALB
# ============================================================
# Recibe el Security Group que permite HTTP desde Internet.

variable "security_group_id" {
  description = "ID del Security Group del ALB"
  type        = string
}


# ============================================================
# INSTANCIA DE APLICACION
# ============================================================
# Recibe el ID de la instancia EC2 que sera registrada como target.

variable "app_instance_id" {
  description = "ID de la instancia EC2 de aplicacion"
  type        = string
}