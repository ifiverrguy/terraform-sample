

provider "aws" {
  region = "us-east-1"
  profile = "ifeoluwa2008"
}

module "dynamodb_table" {
  source = "../../modules/dynamodb"

  table_name        = var.table_name
  attributes        = var.attributes
  read_capacity     = var.read_capacity
  write_capacity    = var.write_capacity
  billing_mode      = var.billing_mode
  hash_key          = var.hash_key
  global_secondary_indexes = var.global_secondary_indexes

  read_min_capacity = var.read_min_capacity
  read_max_capacity = var.read_max_capacity
  read_target_value = var.read_target_value

  write_min_capacity = var.write_min_capacity
  write_max_capacity = var.write_max_capacity
  write_target_value = var.write_target_value
}
