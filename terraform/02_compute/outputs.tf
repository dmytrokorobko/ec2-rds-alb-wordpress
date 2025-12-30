output "subnet_matrix" {
  value = local.subnet_matrix
}

output "bastion_ip" {
  value = aws_instance.ec2[0].public_ip
}