output "ec2_sg_id" {
  value = module.ec2_sg.sg_id
}

output "bastion_ip" {
  value = aws_instance.ec2[0].public_ip
}

output "wordpress_ec2_ids" {
  value = local.wordpress_instance_ids
}

output "wordpress_ec2_private_ip" {
  value = local.wordpress_instance_private_ips
}