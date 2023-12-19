variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "attributes" {
  description = "List of attributes for the DynamoDB table"
  type        = list(object({
    name = string
    type = string
  }))
}

variable "global_secondary_indexes" {
  description = "List of global secondary indexes for the DynamoDB table"
  type        = list(object({
    name            = string
    hash_key        = string
    range_key       = string
    read_capacity   = number
    write_capacity  = number
    projection_type = string
  }))
}

variable "read_capacity" {
  description = "Read capacity units for the DynamoDB table"
  type        = number
}

variable "write_capacity" {
  description = "Write capacity units for the DynamoDB table"
  type        = number
}

variable "hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table"
  type        = string
}

variable "read_min_capacity" {
  description = "Minimum read capacity for DynamoDB auto-scaling"
  type        = number
}

variable "read_max_capacity" {
  description = "Maximum read capacity for DynamoDB auto-scaling"
  type        = number
}

variable "read_target_value" {
  description = "Target utilization percentage for read capacity"
  type        = number
}

variable "write_min_capacity" {
  description = "Minimum write capacity for DynamoDB auto-scaling"
  type        = number
}

variable "write_max_capacity" {
  description = "Maximum write capacity for DynamoDB auto-scaling"
  type        = number
}

variable "write_target_value" {
  description = "Target utilization percentage for write capacity"
  type        = number
}
