output "alb_dns" {
  value = module.ecs-cluster.alb_dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
