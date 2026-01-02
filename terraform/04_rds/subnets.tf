data "aws_availability_zones" "azs" {}

locals {
  azs_list = [
   data.aws_availability_zones.azs.names[0],
   data.aws_availability_zones.azs.names[1]
  ]
}

module "db_subnet" {
  count = length(local.azs_list)
  source = "../modules/aws_subnet"
  availability_zone = local.azs_list[count.index]
  vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
  cidr_data = {
   base = var.cidr_plan.base
   name = "private-subnet-${count.index}"
   newbits = var.cidr_plan.newbits
   netnum = var.cidr_plan.allocations.private[count.index]
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name = "db-subnet-group"
  subnet_ids = [
   for subnet in module.db_subnet :
      subnet.subnet_id
  ]
}