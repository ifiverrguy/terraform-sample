output "lambda_authorizer_arn" {
  description = "ARN of the Lambda Authorizer function"
  value       = aws_lambda_function.example.arn
}
