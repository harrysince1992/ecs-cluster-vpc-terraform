# creates a vpc with the name of the ecs cluster name
locals {
  vpc_name = format("%s-vpc", var.ecs_cluster_name)
  subnets_cidr = cidrsubnets(var.vpc_cidr_range, 2, 2, 2)
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "ecs-vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = local.vpc_name
  }
}

# create three subnets
# private subnet first
resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.ecs-vpc.id
  cidr_block = local.subnets_cidr[0]
  availability_zone = data.aws_availability_zones.azs.names[0]
  tags = {
    Name = format("%s-private-subnet-a", var.ecs_cluster_name)
  }
}

# public subnets secondly
resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.ecs-vpc.id
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block = local.subnets_cidr[1]
  tags = {
    Name = format("%s-public-subnet-a", var.ecs_cluster_name)
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.ecs-vpc.id
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block = local.subnets_cidr[2]
  tags = {
    Name = format("%s-public-subnet-b", var.ecs_cluster_name)
  }
}