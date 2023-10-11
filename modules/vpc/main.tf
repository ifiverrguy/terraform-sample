resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.stack_name}-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_a_cidr
  map_public_ip_on_launch = true
  availability_zone = var.az_a

  tags = {
    Name = "${var.stack_name}-public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_b_cidr
  map_public_ip_on_launch = true
  availability_zone = var.az_b

  tags = {
    Name = "${var.stack_name}-public-subnet-b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "${var.stack_name}-private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "${var.stack_name}-private-subnet-b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.stack_name}-igw"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_vpc.main.main_route_table_id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_vpc.main.main_route_table_id
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.for_nat_a.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "${var.stack_name}-nat-a"
  }
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.for_nat_b.id
  subnet_id     = aws_subnet.public_b.id

  tags = {
    Name = "${var.stack_name}-nat-b"
  }
}

resource "aws_eip" "for_nat_a" {
  tags = {
    Name = "${var.stack_name}-eip-a"
  }
}

resource "aws_eip" "for_nat_b" {
  tags = {
    Name = "${var.stack_name}-eip-b"
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }

  tags = {
    Name = "${var.stack_name}-rt-private-a"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }

  tags = {
    Name = "${var.stack_name}-rt-private-b"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}
