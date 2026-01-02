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

variable "cidr_plan" {
  default   = {
    base    = "10.0.0.0/26"
    newbits = 2
    allocations = {
      public  = [0, 1]
      private = [2, 3]
    }
  }
}

