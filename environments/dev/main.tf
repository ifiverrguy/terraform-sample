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


module "api_gateway" {
  source                = "../../modules/api_gateway"
  api_gateway_name      = var.api_gateway_name
  api_gateway_stage_name = "dev"
}

module "lambda_authorizer" {
  source            = "../../modules/lambda_authorizer"
  function_name     = "customLambdaAuthorizer"
  handler           = "index.handler"
  runtime           = "nodejs14.x"
  execution_role_arn = "arn:aws:iam::123456789012:role/customAuthorizerRole"
  lambda_zip_path   = "./code.zip"
  env_variables     = {
    DUMMY_KEY1 = "dummy_value1",
    DUMMY_KEY2 = "dummy_value2"
  }
}
