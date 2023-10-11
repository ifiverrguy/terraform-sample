module "vpc" {
  source = "../../modules/vpc"

  stack_name = "dev"
  #... other required vars
}