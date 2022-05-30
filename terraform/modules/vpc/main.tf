module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "uol-${var.infra_env}-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs

  enable_nat_gateway     = true
  enable_vpn_gateway = true
  one_nat_gateway_per_az = false

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = {
    Name        = "uol-${var.infra_env}-vpc"
    Project     = "uol-teste"
    Environment = "${var.infra_env}"
  }
}