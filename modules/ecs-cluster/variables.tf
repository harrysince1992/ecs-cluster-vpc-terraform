variable "ecs-cluster-name" {
  description = "name of the ecs cluster"
  type = string
}

variable "vpc_id" {
  description = "VPC ID of the deployed VPC"
  type = string
}

variable "public-subnets" {
  description = "public subnets for the ALB"
  type = list(string)
}