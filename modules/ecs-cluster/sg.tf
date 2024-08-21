# this will create a ECS cluster in the deployed VPC
locals {
  ingress_ports = [80, 443]
}

###################################################################################
# AWS Application Load Balancer Security Group
###################################################################################
resource "aws_security_group" "alb-sg" {
  name = format("%s-alb-sg", var.ecs-cluster-name)
  description = "Allows inbound traffic for ECS cluster ALB"
  vpc_id = var.vpc_id

  tags = {
    Name = format("%s-alb-sg", var.ecs-cluster-name)
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb-ingress-rule" {
  count = length(local.ingress_ports)
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = local.ingress_ports[count.index]
  to_port = local.ingress_ports[count.index]
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb-egress-rule" {
  security_group_id = aws_security_group.alb-sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}
####################################################################################

###################################################################################
# Fargate Containers Security Group
###################################################################################
resource "aws_security_group" "fargate-sg" {
  name = format("%s-fargate-sg", var.ecs-cluster-name)
  description = "Allows inbound traffic for fargate containers"
  vpc_id = var.vpc_id

  tags = {
    Name = format("%s-fargate-sg", var.ecs-cluster-name)
  }
}

resource "aws_vpc_security_group_ingress_rule" "fargate-ingress-rule" {
  security_group_id = aws_security_group.fargate-sg.id
  referenced_security_group_id = aws_security_group.alb-sg.id
  from_port = 3000
  to_port = 3000
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "fargate-egress-rule" {
  security_group_id = aws_security_group.fargate-sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}
####################################################################################