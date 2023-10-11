variable "stack_name" {
  description = "The stack name to prepend to resources."
  type        = string
  default     = "dev"  # This sets the default value for the 'dev' environment.
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the first public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "The CIDR block for the second public subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  description = "The CIDR block for the first private subnet."
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  description = "The CIDR block for the second private subnet."
  type        = string
  default     = "10.0.4.0/24"
}
