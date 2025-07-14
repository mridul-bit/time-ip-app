output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.ecs_alb.dns_name

}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.time_ip_cluster.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.time_ip_service.name
}

