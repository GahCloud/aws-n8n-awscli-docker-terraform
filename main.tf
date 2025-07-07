provider "aws" {
  region = "sa-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  ami               = "ami-0a174b8e659123575"
  instance_type     = "t2.micro"
  key_name          = "nuvemkey"
  security_group_id = module.security_group.security_group_id
  instance_name     = "Hello"
  user_data         = file("${path.module}/user_data.sh")
}
