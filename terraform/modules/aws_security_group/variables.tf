variable "sg_data" {
  type = object({
    name = string
    vpc_id = string
    egress_cidr_blocks = list(string)
    ingress = list(object({
      port = number
      cidr_blocks = list(string)
      security_groups = list(string)
    }))
  })
}