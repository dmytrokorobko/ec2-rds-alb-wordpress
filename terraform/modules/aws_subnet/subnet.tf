resource "aws_subnet" "subnet" {
  availability_zone = var.availability_zone
  cidr_block = cidrsubnet(var.cidr_data.base, var.cidr_data.newbits, var.cidr_data.netnum)
  vpc_id = var.vpc_id
  tags = {
    Name = var.cidr_data.name
  }
}