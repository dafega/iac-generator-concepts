output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs_cluster.cluster_arn
}

output "backend_service_arn" {
  description = "ARN of the backend Node.js ECS service"
  value       = module.svc_backend_nodejs.service_arn
}

output "ecr_repository_urls" {
  description = "URLs of ECR repositories for this environment"
  value       = module.ecr.repository_urls
}

output "dynamodb_table_param_name" {
  description = "SSM parameter name that stores the DynamoDB table name"
  value       = module.dynamodb_connection.parameter_name
}

