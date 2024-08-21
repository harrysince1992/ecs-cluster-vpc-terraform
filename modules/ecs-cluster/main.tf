resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs-cluster-name

  setting {
    name  = "containerInsights"
    value = "disabled"
  }

  tags = {
    Name = var.ecs-cluster-name
  }
}