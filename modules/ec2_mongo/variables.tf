# ============================================================
# TIPO DE INSTANCIA
# ============================================================
# Define el tamaño de la instancia EC2 utilizada por MongoDB.

variable "instance_type" {
  description = "Tipo de instancia EC2 para MongoDB"
  type        = string
  default     = "t3.micro"
}


# ============================================================
# SUBNET PRIVADA
# ============================================================
# Recibe la subnet privada donde se desplegara MongoDB.

variable "subnet_id" {
  description = "ID de la subnet privada para MongoDB"
  type        = string
}


# ============================================================
# SECURITY GROUP DE MONGODB
# ============================================================
# Recibe el Security Group que permite MongoDB solamente desde la aplicacion.

variable "security_group_id" {
  description = "ID del Security Group de MongoDB"
  type        = string
}
