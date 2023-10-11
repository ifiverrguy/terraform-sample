variable "stack_name" {
  description = "The stack name to prepend to resources."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the first public subnet."
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "The CIDR block for the second public subnet."
  type        = string
}

variable "private_subnet_a_cidr" {
  description = "The CIDR block for the first private subnet."
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "The CIDR block for the second private subnet."
  type        = string
}

variable "allowed_ports" {
  description = "The ports to allow in the NACLs."
  type        = list(number)
  default     = [80, 443]
}
