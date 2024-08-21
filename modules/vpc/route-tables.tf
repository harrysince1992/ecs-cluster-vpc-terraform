resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-public-rt", var.ecs_cluster_name)
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.ecs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = format("%s-private-rt", var.ecs_cluster_name)
  }
}

resource "aws_route_table_association" "private-rta" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.private-subnet-1.id
}

resource "aws_route_table_association" "public-rta-1" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-rta-2" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.public-subnet-2.id
}