terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
  
  backend "s3" {
    bucket         = "dmytro-project-example-terraform-state"
    key            = "lab24/alb/terraform.tfstate"
    region         = "us-east-1"
  }
}

data "terraform_remote_state" "network_state" {
  backend = "s3"
  config = {
    bucket         = "dmytro-project-example-terraform-state"
    key            = "lab24/network/terraform.tfstate"
    region         = "us-east-1"
  }
}

data "terraform_remote_state" "compute_state" {
  backend = "s3"
  config = {
    bucket         = "dmytro-project-example-terraform-state"
    key            = "lab24/compute/terraform.tfstate"
    region         = "us-east-1"
  }
}
