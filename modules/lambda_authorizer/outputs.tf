output "lambda_function_arn" {
  value = aws_lambda_function.example.arn
}

output "lambda_execution_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}
output "lambda_authorizer_arn" {
  description = "ARN of the Lambda Authorizer function"
  value       = aws_lambda_function.example.arn
}
