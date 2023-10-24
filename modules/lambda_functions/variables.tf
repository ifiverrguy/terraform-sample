variable "lambda_execution_role_arn" {
    description = "ARN of the IAM role to use for Lambda execution"
}
variable "app_lambdas" {
  description = "Lambda configurations passed from the environment"
  type = map(object({
    name       = string
    handler    = string
    memory     = number
    timeout    = number
    env_vars   = map(string)
    mts        = bool
    dva        = bool
    recalls    = bool
    cvs        = bool
    bulk       = bool
  }))
}
