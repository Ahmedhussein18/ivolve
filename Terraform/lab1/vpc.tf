data "aws_vpc" "ivolve" {
  filter {
    name   = "tag:Name"
    values = ["ivolve"]
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = data.aws_vpc.ivolve.id
  cidr_block = var.subnet_cidr_1
   map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id     = data.aws_vpc.ivolve.id
  cidr_block = var.subnet_cidr_2
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.ivolve.id

  tags = {
    Name = "ivolve-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = data.aws_vpc.ivolve.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table_association" "subnet1_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet2_assoc" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

