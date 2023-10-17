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

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Controls how you are billed for read and write throughput"
  type        = string
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = "The number of read units for this table"
  type        = number
}

variable "write_capacity" {
  description = "The number of write units for this table"
  type        = number
}

variable "hash_key" {
  description = "The attribute to use as the hash key. E.g., 'ID'"
  type        = string
  default    = "ID"
}

variable "api_gateway_name" {
  description = "Name for the API Gateway"
  default     = "dev-api-gateway"
}

variable "waf_countries_allowed" {
  description = "List of country codes to allow in WAF"
  type        = list(string)
  default     = ["US", "CA"]
}

