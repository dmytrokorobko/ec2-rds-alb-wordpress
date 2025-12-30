resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_plan.base
  tags = {
    Name = "VPC-Lab24"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}