resource "aws_lambda_function" "this" {
  for_each = var.lambda_configs

  function_name = each.value.function_name
  handler       = each.value.handler
  runtime       = each.value.runtime
  role          = var.lambda_execution_role_arn
  filename      = each.value.lambda_zip_path

  environment {
    variables = each.value.env_variables
  }
}

variable "lambda_configs" {
  description = "Map of configuration values for each Lambda function"
  type = map(object({
    function_name      = string
    handler            = string
    runtime            = string
    lambda_zip_path    = string
    env_variables      = map(string)
  }))
  default = {}
}
