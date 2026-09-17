variable "vpc_cidr" {
  description = "CIDR de la VPC principal"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR de la subred publica"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR de la subred privada"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidad para las subredes"
  type        = string
}
variable "public_subnet_2_cidr" {
  description = "CIDR de la segunda subred publica"
  type        = string
}

variable "availability_zone_2" {
  description = "Segunda zona de disponibilidad"
  type        = string
}