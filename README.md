# AWS Infrastructure: EC2 + ALB + RDS (Terraform & Ansible)

This project demonstrates a layered AWS infrastructure built with Terraform and validated with Ansible connectivity.

## Architecture Overview
- **Network layer**: VPC with public and private subnets, routing, and internet gateway.
- **Compute layer**:
  - Bastion host in public subnet
  - Multiple EC2 application nodes in public subnets
- **Load Balancer layer**:
  - Application Load Balancer
  - Target Groups and Security Group rules (SG → SG)
- **Database layer**:
  - Amazon RDS (MySQL) in private subnets
  - Dedicated subnet group and security group

## Infrastructure as Code
- Terraform is organized into **independent layers**, each with its own state.
- Reusable Terraform modules are used for common resources (subnets, security groups).
- Security follows least-privilege principles using Security Group references instead of CIDR-based access where possible.

## Ansible
- Ansible is used to validate access to EC2 instances.
- Dynamic inventory is generated from Terraform outputs.
- SSH access is performed securely via a bastion host using ProxyJump.
- Application deployment (e.g. WordPress) is intentionally out of scope.

## Purpose
The goal of this project is to practice and demonstrate:
- AWS infrastructure design
- Terraform layering and state separation
- Secure access patterns with bastion hosts
- Ansible connectivity and dynamic inventory

Application-level configuration was intentionally excluded to focus on infrastructure and operations fundamentals.
