module "vpc" {
  source = "../../modules/vpc"

  stack_name = "prod"
  #... other required vars
}
