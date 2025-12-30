module "ip" {
  source = "../modules/http_ip"
}

module "bastion_sg" {
  source = "../modules/aws_security_group"
  sg_data = {
    name = "bastion-sg"
    vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
    egress_cidr_blocks = ["0.0.0.0/0"]
    ingress = [
      {
         port = 22
         cidr_blocks = ["${module.ip.my_ip}/32"]
         security_groups = null
      }
    ]
  }
}

module "ec2_sg" {
  source = "../modules/aws_security_group"
  sg_data = {
    name = "ec2-sg"
    vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
    egress_cidr_blocks = ["0.0.0.0/0"]
    ingress = []
  }
}

locals {
  key_name = "lab"
  
  subnets = data.terraform_remote_state.network_state.outputs.public_subnets_id
  subnet_matrix = flatten([
   for subnet in local.subnets : [
      for i in range(var.ec2_instances_per_subnet) : 
         subnet
   ]
  ])

  wordpress_instance_ids = [
    for inst in aws_instance.ec2 :
      inst.id
      if inst.tags["Role"] == "wordpress"
  ]
}

resource "aws_key_pair" "key" {
  key_name = local.key_name
  public_key = file("${path.module}/lab20.pub")
}

resource "aws_instance" "ec2" {
  count = var.ec2_instances_per_subnet * length(local.subnets) + 1
  ami = data.aws_ami.ubuntu_ami.id
  associate_public_ip_address = true
  instance_type = "t3.micro"
  key_name = count.index == 0 ? local.key_name : null
  subnet_id = count.index == 0 ? local.subnets[0] : local.subnet_matrix[count.index - 1]
  tags = {
    Name = count.index == 0 ? "Bastion" : "Wordpress #${count.index}"
    Role = count.index == 0 ? "bastion" : "wordpress"
  }
  vpc_security_group_ids = count.index == 0 ? [module.bastion_sg.sg_id] : [module.ec2_sg.sg_id]
}