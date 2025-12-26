terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
  
  backend "s3" {
    bucket         = "s3-bucket-name"
    key            = "project_name/layer_name/terraform.tfstate"
    region         = "us-east-1"
  }
}

// Example: use terraform_remote_state to consume outputs from another layer
// Enable and adjust when adding dependent layers (e.g. 02_compute)
//
//data "terraform_remote_state" "network_state" {
//  backend = "s3"
//  config = {
//    bucket         = "s3-bucket-name"
//    key            = "project_name/layer_name/terraform.tfstate"
//    region         = "us-east-1"
//  }
//}
