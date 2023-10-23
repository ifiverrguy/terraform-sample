# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_execution_role" {
  name = "LambdaExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

# Policy to allow Lambda to write logs to CloudWatch Logs
resource "aws_iam_policy" "lambda_logging" {
  name        = "LambdaLoggingPolicy"
  description = "Allow Lambda to write logs to CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Attach necessary permissions to the Lambda execution role.
resource "aws_iam_role_policy_attachment" "lambda_s3_full_access" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_logging_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

# Lambda Function Resource
resource "aws_lambda_function" "example" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  
  # Use the ARN of the IAM role we created above
  role          = aws_iam_role.lambda_execution_role.arn

  filename         = var.lambda_zip_path
  source_code_hash = filebase64(var.lambda_zip_path)

  environment {
    variables = var.env_variables
  }
}

