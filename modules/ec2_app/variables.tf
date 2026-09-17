# ============================================================
# AMI DE LA APLICACION
# ============================================================
# Recibe la AMI que utilizará la instancia EC2 de Nginx y Node.js.

variable "ami_id" {
  description = "AMI utilizada por la instancia de aplicacion"
  type        = string
}


# ============================================================
# TIPO DE INSTANCIA
# ============================================================
# Define el tamaño de la instancia EC2 utilizada por la aplicacion.

variable "instance_type" {
  description = "Tipo de instancia EC2 para la aplicacion"
  type        = string
  default     = "t3.micro"
}


# ============================================================
# SUBNET PUBLICA
# ============================================================
# Recibe la subnet donde se desplegará la instancia de aplicacion.

variable "subnet_id" {
  description = "ID de la subnet para la instancia de aplicacion"
  type        = string
}


# ============================================================
# SECURITY GROUP DE LA APLICACION
# ============================================================
# Recibe el Security Group que protege la instancia Nginx y Node.js.

variable "security_group_id" {
  description = "ID del Security Group de la aplicacion"
  type        = string
}