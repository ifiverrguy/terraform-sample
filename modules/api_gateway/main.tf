resource "aws_api_gateway_rest_api" "example" {
  name        = var.api_gateway_name
  description = "An example API Gateway REST API"
}


data "aws_region" "current" {}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.example.id
}

resource "aws_api_gateway_authorizer" "lambda_authorizer" {
  name                   = "lambda-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.example.id
  authorizer_uri = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${var.lambda_authorizer_arn}/invocations"
  authorizer_credentials = var.lambda_authorizer_execution_role_arn
  type                   = "TOKEN"
  identity_source        = "method.request.header.Authorization"
}

resource "aws_api_gateway_resource" "resource" {
  for_each = var.app_lambdas

  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = each.value.name
}

resource "aws_api_gateway_method" "method" {
  for_each = aws_api_gateway_resource.resource

  rest_api_id   =  aws_api_gateway_rest_api.example.id
  resource_id   = each.value.id
  http_method   = var.app_lambdas[each.key].http_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer.id
}

resource "aws_api_gateway_integration" "integration" {
  for_each = aws_api_gateway_method.method

  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = each.value.resource_id
  http_method = each.value.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${var.lambda_function_uris[each.key]}/invocations"
}

resource "aws_lambda_permission" "api_gw_lambda_invoke" {
  for_each = var.lambda_function_uris

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = each.value
  principal     = "apigateway.amazonaws.com"
  # This source ARN should point to the specific method ARN of the API Gateway that's allowed to invoke the Lambda function
  source_arn    = "${aws_api_gateway_rest_api.example.execution_arn}/*/*/*"
}
