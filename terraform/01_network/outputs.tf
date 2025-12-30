output "region" {
  description = "The AWS region in use"
  value       = var.region
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = module.public_subnets[*].subnet_id
}
