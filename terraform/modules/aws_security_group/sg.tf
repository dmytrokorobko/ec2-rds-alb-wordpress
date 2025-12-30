resource "aws_security_group" "sg" {
  name = var.sg_data.name
  vpc_id = var.sg_data.vpc_id
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = var.sg_data.egress_cidr_blocks
  }

  dynamic "ingress" {
    for_each = var.sg_data.ingress
    content {
     from_port = ingress.value.port
     to_port = ingress.value.port
     protocol = "tcp"
     cidr_blocks = ingress.value.cidr_blocks
     security_groups = ingress.value.security_groups
    }
  }
}