variable "vpc-config" {
  description = "To get the CIDR and Name the vpc from user."
  type = object({
    cidr_block = string
    name = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc-config.cidr_block))
    error_message = "Invalid CIDR format - ${var.vpc-config.cidr_block}"
  }
}
variable "subnet-config" {
  description = "Get the CIDR and AZ for the subnets"
  type = map(object({
    cidr_block  = string
    az = string
    public = optional(bool, false)
  }))
   validation {
    condition = alltrue([for config in var.subnet-config: can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR format"
  }
}