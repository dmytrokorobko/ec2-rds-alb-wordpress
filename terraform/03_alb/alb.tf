module "alb_sg" {
  source = "../modules/aws_security_group"
  sg_data = {
    name = "alb-sg"
    vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
    egress_cidr_blocks = ["0.0.0.0/0"]
    ingress = [{
      port = 80
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = null
    }]
  }
}

resource "aws_security_group_rule" "alb_to_ec2_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"

  security_group_id = data.terraform_remote_state.compute_state.outputs.ec2_sg_id
  source_security_group_id = module.alb_sg.sg_id
}

resource "aws_lb" "alb" {
  name = "alb"
  security_groups = [module.alb_sg.sg_id]
  subnets = [for subnet in data.terraform_remote_state.network_state.outputs.public_subnets_id : subnet]
  tags = {
    Env = "Development"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}