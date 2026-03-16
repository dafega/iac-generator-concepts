module "network" {
  source = "../../modules/network"

  name_prefix          = "iac-${var.env}"
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.11.0/24", "10.1.12.0/24"]
}

module "logging" {
  source = "../../modules/logging"

  name_prefix = "iac-${var.env}"
}

module "secrets" {
  source = "../../modules/secrets"

  env         = var.env
  name_prefix = "iac-${var.env}"
}

module "ecr" {
  source = "../../modules/ecr"

  env         = var.env
  name_prefix = "iac-${var.env}"
  repositories = [
    "backend-nodejs",
    "agente-extraccion-imagenes",
    "agente-generador",
    "integrador-github",
    "errores-retry-circuit",
  ]
}

module "alb" {
  source = "../../modules/alb"

  name_prefix       = "iac-${var.env}"
  vpc_id            = module.network.vpc_id
  public_subnets    = module.network.public_subnet_ids
  health_check_path = "/health"
}

module "ecs_cluster" {
  source = "../../modules/ecs_cluster"

  name_prefix     = "iac-${var.env}"
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnet_ids
}

module "svc_backend_nodejs" {
  source = "../../modules/ecs_service"

  name_prefix           = "iac-${var.env}-backend-nodejs"
  cluster_arn           = module.ecs_cluster.cluster_arn
  desired_count         = 3
  cpu                   = 512
  memory                = 1024
  container_image       = module.ecr.repository_urls["backend-nodejs"]
  container_port        = 3000
  env                   = var.env
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_subnet_ids
  alb_listener_arn      = module.alb.http_listener_arn
  alb_security_group_id = module.alb.security_group_id
  log_group_name        = module.logging.log_group_name
}

module "dynamodb_connection" {
  source = "../../modules/dynamodb_connection"

  env        = var.env
  table_name = "mi-tabla-app-existente"
}

