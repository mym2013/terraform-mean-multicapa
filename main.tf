# ============================================================
# CONFIGURACION DE TERRAFORM
# ============================================================
# Define la version de Terraform y el provider AWS requerido.

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


# ============================================================
# PROVIDER AWS
# ============================================================
# Define AWS como proveedor y us-east-1 como region de trabajo.

provider "aws" {
  region = "us-east-1"
}


# ============================================================
# MODULO NETWORK
# ============================================================
# Crea la VPC, subnets publica y privada, Internet Gateway y NAT Gateway.

module "network" {
  source = "./modules/network"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

# ============================================================
# MODULO SECURITY GROUPS
# ============================================================
# Crea las reglas de seguridad para ALB, aplicacion y MongoDB.

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.network.vpc_id
}
# ============================================================
# MODULO EC2 APP
# ============================================================
# Crea la instancia EC2 para Nginx y Node.js.

module "ec2_app" {
  source = "./modules/ec2_app"

  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security_groups.app_sg_id
}
# ============================================================
# MODULO EC2 MONGODB
# ============================================================
# Crea la instancia EC2 privada para MongoDB.

module "ec2_mongo" {
  source = "./modules/ec2_mongo"

  subnet_id         = module.network.private_subnet_id
  security_group_id = module.security_groups.mongo_sg_id
}
# ============================================================
# MODULO APPLICATION LOAD BALANCER
# ============================================================
# Distribuye trafico HTTP desde Internet hacia la instancia de aplicacion.

module "alb" {
  source = "./modules/alb"

  vpc_id = module.network.vpc_id

  public_subnet_ids = [
    module.network.public_subnet_id,
    module.network.public_subnet_2_id
  ]

  security_group_id = module.security_groups.alb_sg_id
  app_instance_id   = module.ec2_app.instance_id
}