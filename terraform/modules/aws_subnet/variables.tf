variable "availability_zone" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cidr_data" {
  type = object({
    base = string
    newbits = number
    netnum = number
    name = string
  })
}