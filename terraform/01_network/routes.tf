resource "aws_route_table" "rt_public" {
  tags = {
    Name = "Public Route Table"
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "route_igw" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rt_subnet_assoc" {
  count = length(local.azs_list)
  route_table_id = aws_route_table.rt_public.id
  subnet_id = module.public_subnets[count.index].subnet_id
}