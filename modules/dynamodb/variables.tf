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
  default     = 1
}

variable "write_capacity" {
  description = "The number of write units for this table"
  type        = number
  default     = 1
}

variable "hash_key" {
  description = "The attribute to use as the hash key. E.g., 'ID'"
  type        = string
}
