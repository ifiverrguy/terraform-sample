variable "function_name" {
  description = "Name of the Lambda Authorizer function"
}

variable "handler" {
  description = "Lambda function handler"
}

variable "runtime" {
  description = "Lambda function runtime"
}


variable "lambda_zip_path" {
  description = "Path to the Lambda function code ZIP file"
}

variable "env_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
}
