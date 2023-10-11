variable "stack_name" {
  description = "The stack name to prepend to resources."
  type        = string
  default     = "prod"  # This sets the default value for the 'prod' environment.
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.1.0.0/16"  # This CIDR is just an example, adjust as necessary.
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the first public subnet."
  type        = string
  default     = "10.1.1.0/24"  # Adjust the CIDR blocks as necessary.
}

variable "public_subnet_b_cidr" {
  description = "The CIDR block for the second public subnet."
  type        = string
  default     = "10.1.2.0/24"
}

variable "private_subnet_a_cidr" {
  description = "The CIDR block for the first private subnet."
  type        = string
  default     = "10.1.3.0/24"
}

variable "private_subnet_b_cidr" {
  description = "The CIDR block for the second private subnet."
  type        = string
  default     = "10.1.4.0/24"
}
