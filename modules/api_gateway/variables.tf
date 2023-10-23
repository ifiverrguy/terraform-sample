variable "api_gateway_name" {
  description = "Name of the API Gateway"
}

variable "api_gateway_stage_name" {
  description = "Name of the API Gateway stage"
}

variable "lambda_authorizer_arn" {
  description = "ARN of the Lambda authorizer function"
  type        = string
}

variable "lambda_authorizer_execution_role_arn" {
  description = "ARN of the execution role for the Lambda authorizer"
  type        = string
}

variable "lambda_function_uris" {
  description = "Map of Lambda function ARNs for integration with API Gateway"
  type        = map(string)
  default     = {}
}
