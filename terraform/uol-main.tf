terraform {
  backend "s3" {
    bucket         = "terraform-uol-ohio"
    key            = "terraform-test.tfstate"
    region         = "us-east-2"
  }
}

provider "aws" {
  region  = "us-east-1"
}


data "aws_ami" "ubuntu" {
  most_recent = true


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

module "vpc" {
  source          = "./modules/vpc"
  infra_env       = "staging"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}


module "ec2-private-a" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_private_subnets[0]
  key_name               = "key_isaque"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-private-b" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_private_subnets[1]
  key_name               = "key_isaque"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-private-c" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.module_vpc_security_group_ids]
  subnet_id              = module.vpc.module_private_subnets[2]
  key_name               = "key_isaque"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-public-a" {
  source                 = "./modules/ec2"
  number_servers         = 1
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = ["sg-0127ecaa29e9498b6"]
  subnet_id              = module.vpc.module_public_subnets[0]
  key_name               = "key_isaque"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-public-b" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = ["sg-0127ecaa29e9498b6"]
  subnet_id              = module.vpc.module_public_subnets[1]
  key_name               = "key_isaque"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}

module "ec2-public-c" {
  source                 = "./modules/ec2"
  number_servers         = 0
  ami                    = data.aws_ami.ubuntu.id
  infra_env              = "staging"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = ["sg-0127ecaa29e9498b6"]
  subnet_id              = module.vpc.module_public_subnets[2]
  key_name               = "key_isaque"
  volume_size_root       = "10"
  volume_type            = "gp3"
  device_name            = "/dev/xvda"
  volume_size_ebs_add    = "20"
}
