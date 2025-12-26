variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner     = "Dmytro K"
    Project   = "TF-ANS-Labs"
    LabName   = "terraform"
  }  
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"    
}
