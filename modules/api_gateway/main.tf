resource "aws_api_gateway_rest_api" "example" {
  name        = var.api_gateway_name
  description = "An example API Gateway REST API"
}

resource "aws_api_gateway_resource" "example_root" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_method" "example_method" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.example_root.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "example_integration" {
  rest_api_id          = aws_api_gateway_rest_api.example.id
  resource_id          = aws_api_gateway_resource.example_root.id
  http_method          = aws_api_gateway_method.example_method.http_method
  integration_http_method = "POST"
  type                 = "MOCK"
  request_templates = {
    "application/json" = jsonencode({
      statusCode = 200
    })
  }
}

resource "aws_api_gateway_deployment" "example" {
  depends_on = [aws_api_gateway_integration.example_integration]
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = var.api_gateway_stage_name
}

resource "aws_wafv2_web_acl" "example" {
  name        = "${var.api_gateway_name}-waf"
  description = "WAF for ${var.api_gateway_name} API Gateway"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "exampleAPIMetric"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "${var.api_gateway_name}-waf"
  }
}

resource "aws_wafv2_web_acl_association" "example_association" {
  web_acl_arn  = aws_wafv2_web_acl.example.arn
  resource_arn = "arn:aws:apigateway:${data.aws_region.current.name}::/restapis/${aws_api_gateway_rest_api.example.id}/stages/${aws_api_gateway_deployment.example.stage_name}"
}

data "aws_region" "current" {}


output "api_gateway_id" {
  value = aws_api_gateway_rest_api.example.id
}
