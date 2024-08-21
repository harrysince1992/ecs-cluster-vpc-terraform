# A VPC module that creates below resources
# 1. a vpc
# 2. three subnets: 2 public and 1 private
# 3. an internet gateway
# 4. a NAT gateway for private subnets
# 5. Route tables for private and public subnets
module "vpc" {
  source           = "./modules/vpc"
  ecs_cluster_name = var.ecs-cluster-name
  vpc_cidr_range   = var.vpc_cidr_range
}

module "ecs-cluster" {
  source           = "./modules/ecs-cluster"
  ecs-cluster-name = var.ecs-cluster-name
  vpc_id           = module.vpc.vpc_id
  public-subnets   = module.vpc.public-subnets
  depends_on       = [module.vpc]
}

