output "vpc_id" {
  value = aws_vpc.ecs-vpc.id
}

output "public-subnets" {
  value = tolist([aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id])
}