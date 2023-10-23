provider "aws" {
  profile                 = "ifeoluwa2008"
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
  lambda_zip_path   = "./code.zip"
  env_variables     = {
    DUMMY_KEY1 = "dummy_value1",
    DUMMY_KEY2 = "dummy_value2"
  }
}




module "lambda_functions" {
  source = "../../modules/lambda_functions"
  lambda_execution_role_arn = module.lambda_authorizer.lambda_execution_role_arn
  lambda_configs = {
    POST    = { function_name = "postFunction", handler = "index.post", runtime = "nodejs14.x", execution_role_arn = "arn:aws:iam::123456789012:role/postRole", lambda_zip_path = "./post.zip", env_variables = {} },
    READ    = { function_name = "readFunction", handler = "index.read", runtime = "nodejs14.x", execution_role_arn = "arn:aws:iam::123456789012:role/readRole", lambda_zip_path = "./read.zip", env_variables = {} },
    DELETE  = { function_name = "createFunction", handler = "index.create", runtime = "nodejs14.x", execution_role_arn = "arn:aws:iam::123456789012:role/createRole", lambda_zip_path = "./delete.zip", env_variables = {} },
    PUT  = { function_name = "createFunction", handler = "index.put", runtime = "nodejs14.x", execution_role_arn = "arn:aws:iam::123456789012:role/createRole", lambda_zip_path = "./put.zip", env_variables = {} }
  }
}


module "api_gateway" {
  source                = "../../modules/api_gateway"
  api_gateway_name      = var.api_gateway_name
  api_gateway_stage_name = "dev"
  lambda_authorizer_arn   = module.lambda_authorizer.lambda_function_arn
  lambda_authorizer_execution_role_arn = module.lambda_authorizer.lambda_execution_role_arn
  lambda_function_uris = module.lambda_functions.lambda_arns
}


