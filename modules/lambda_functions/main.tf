resource "aws_lambda_function" "this" {
  for_each = local.lambda_configs

  function_name = each.value.function_name
  handler       = each.value.handler
  runtime       = each.value.runtime
  role          = var.lambda_execution_role_arn
  filename      = each.value.lambda_zip_path

  environment {
    variables = each.value.env_variables
  }

}


locals {
  lambda_configs = {
    for key, value in var.app_lambdas : key => {
      function_name   = value.name,
      handler         = value.handler,
      runtime         = "nodejs14.x",  # This value is hardcoded. Modify if required.
      lambda_zip_path = "./code.zip",  # Provide the appropriate zip path.
      env_variables   = value.env_vars
    }
  }
}