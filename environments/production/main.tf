module "vpc" {
  source = "../../modules/vpc"

  stack_name           = var.stack_name
  cidr_block           = var.cidr_block
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
}
