resource "aws_nat_gateway" "nat-gw" {
  subnet_id = aws_subnet.public-subnet-1.id
  allocation_id = aws_eip.eip.id
}

resource "aws_eip" "eip" {
  domain = "vpc"
}