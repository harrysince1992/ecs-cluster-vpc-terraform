# ECS Cluster VPC Terraform Code
## This terraform code will require below inputs

**Required Inputs**
- vpc_cidr_range: Range of the VPC CIDR. *default is 10.0.0.0/24*
- ecs-cluster-name: Name of the ECS cluster to Create. Default is *demo-ecs-cluster*
- access_key: access key of AWS account where you want resources to be created
- secret_key: secret key of AWS account where you want resources to be created
- region: AWS region. *(Must be either us-east-1 or ap-south-1). Other regions are not supported*

## The code will create below resources:
1. A VPC
2. 3 Subnets: 2 Public and 1 Private
3. an Internet Gateway
4. A NAT gateway
5. 2 Route Tables: one for Public subnet and other for private subnet
6. Route Table Associations for Public and Private Subnet
7. An Application Load Balancer with one HTTP port 80 listener enabled
8. A Target Group for Fargate Instances
9. An ECS Cluster with default configuration *ContainerInsights Disabled*
10. Security Group for ALB
11. Security Group for ECS Fargate Instances

## What You will need to create
1. An ECS service
2. A Task Definition
