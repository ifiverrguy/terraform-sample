locals {
  app_lambdas = {
    EnhancedGetVehicleByRegistration = {
      name       = "EnhancedGetVehicleByRegistration",
      handler    = "app.handler",
      memory     = 256,
      timeout    = 60,
      env_vars   = {},
      mts        = true,
      dva        = true,
      recalls    = true,
      cvs        = false,
      bulk       = false,
    },
    GetVehicleBulkDownloadURLs = {
      name       = "GetVehicleBulkDownloadURLs",
      handler    = "app.handler",
      memory     = 256,
      timeout    = 60,
      env_vars   = {},
      mts        = false,
      dva        = false,
      recalls    = false,
      cvs        = false,
      bulk       = true,
    }
  }
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
  app_lambdas = local.app_lambdas
}


module "api_gateway" {
  source                = "../../modules/api_gateway"
  api_gateway_name      = var.api_gateway_name
  api_gateway_stage_name = "dev"
  lambda_authorizer_arn   = module.lambda_authorizer.lambda_function_arn
  lambda_authorizer_execution_role_arn = module.lambda_authorizer.lambda_execution_role_arn
  lambda_function_uris = module.lambda_functions.lambda_arns
  app_lambdas = local.app_lambdas
}


