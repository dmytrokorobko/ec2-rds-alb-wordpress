resource "aws_lb_target_group" "tg" {
  name = "alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
}

resource "aws_lb_target_group_attachment" "tg_attach" {
  for_each = toset(data.terraform_remote_state.compute_state.outputs.wordpress_ec2_ids)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = each.value
  port = 80
}