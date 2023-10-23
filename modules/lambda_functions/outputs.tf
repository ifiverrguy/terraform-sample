output "lambda_arns" {
  value = { for k, lambda in aws_lambda_function.this : k => lambda.arn }
  description = "ARNs of the created Lambda functions"
}
