resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ecs-vpc.id

  tags = {
    Name = format("%s-igw", var.ecs_cluster_name)
  }
}

