# This creates an application load balancer and its related components

resource "aws_lb" "demo-alb" {
  name = format("%s-alb", var.ecs-cluster-name)
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]
  subnets = [for subnet in var.public-subnets: subnet]
  enable_deletion_protection = false

  tags = {
    Name = format("%s-alb", var.ecs-cluster-name)
  }
}

# Target group for fargate services
resource "aws_lb_target_group" "fargate-tg" {
  name = "fargate-tg"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"
  depends_on = [aws_ecs_cluster.ecs-cluster]
}

# Listener for the ALB
resource "aws_lb_listener" "http-listener" {
  load_balancer_arn = aws_lb.demo-alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.fargate-tg.arn
  }
}

#resource "aws_lb_listener" "https-listener" {
#  load_balancer_arn = aws_lb.demo-alb.arn
#  port = 443
#  protocol = "HTTPS"
#  ssl_policy = "ELBSecurityPolicy-2016-08"
#  certificate_arn = ""
#}

