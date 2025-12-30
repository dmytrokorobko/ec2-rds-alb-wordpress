data "aws_availability_zones" "azs" {}

check "azs_number" {
  assert {
    condition = length(data.aws_availability_zones.azs.names) >= 2
    error_message = "There isn't enough availability zones in selected region"
  }
}

locals {
  azs_list = [
   data.aws_availability_zones.azs.names[0],
   data.aws_availability_zones.azs.names[1]
  ]
}

module "public_subnets" {
  count = length(local.azs_list)
  source = "../modules/aws_subnet"
  availability_zone = local.azs_list[count.index]
  cidr_data = {
    base = var.cidr_plan.base
    newbits = var.cidr_plan.newbits
    netnum = var.cidr_plan.allocations.public[count.index]
    name = "Public Subnet #${count.index + 1}"
  }
  vpc_id = aws_vpc.vpc.id
}


