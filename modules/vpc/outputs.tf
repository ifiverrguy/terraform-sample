output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
