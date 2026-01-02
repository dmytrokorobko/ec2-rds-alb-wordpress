module "rds_sg" {
  source = "../modules/aws_security_group"
  sg_data = {
    name = "rds-sg"
    vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
    egress_cidr_blocks = ["0.0.0.0/0"]
    ingress = [
      {
         port = 3306
         cidr_blocks = []
         security_groups = [data.terraform_remote_state.compute_state.outputs.ec2_sg_id]
      }
    ]
  }
}