
provider "aws" {
  region = "us-east-1"
  profile = "ifeoluwa2008"
}

module "vpc" {
  source = "../../modules/vpc"

  stack_name           = var.stack_name
  cidr_block           = var.cidr_block
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
}

module "dynamodb_table" {
  source = "../../modules/dynamodb"

  table_name     = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
}


module "lambda_authorizer" {
  source            = "../../modules/lambda_authorizer"
  function_name     = "customLambdaAuthorizer"
  handler           = "index.handler"
  runtime           = "nodejs14.x"
  lambda_zip_path   = "./authorizer.zip"
  env_variables     = {
    DUMMY_KEY1 = "dummy_value1",
    DUMMY_KEY2 = "dummy_value2"
  }
}



module "lambda_functions" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "6.0.1"
  for_each = var.app_lambdas
  
  function_name = each.value.name
  handler       = each.value.handler
  runtime       = each.value.runtime
  memory_size   = each.value.memory
  timeout       = each.value.timeout
  create_package         = false
  local_existing_package   = each.value.filename

  # You might need to adjust this depending on how the module expects environment variables:
  environment_variables = each.value.env_vars

}


locals {
  lambda_arn_map = { for key, value in module.lambda_functions : key => value.lambda_function_arn }
}


module "api_gateway" {
  source                = "../../modules/api_gateway"
  api_gateway_name      = var.api_gateway_name
  api_gateway_stage_name = "dev"
  lambda_authorizer_arn   = module.lambda_authorizer.lambda_function_arn
  lambda_authorizer_execution_role_arn = module.lambda_authorizer.lambda_execution_role_arn
  lambda_function_uris = local.lambda_arn_map
  app_lambdas  = var.app_lambdas
}
