variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner     = "Dmytro K"
    Project   = "TF-ANS-Labs"
    LabName   = "Lab24"
  }  
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"    
}

variable "ec2_instances_per_subnet" {
  description = "Number of application instances deployed per public subnet"
  type = number
  default = 2
}

