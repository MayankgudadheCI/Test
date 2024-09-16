provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_access_key
  region     = "ap-south-1"
}

module "ec2-instance" {
  source        = "./modules/ec2-instance"
  ami           = "ami-0d1e92463a5acf79d"
  instance_type = "t2.micro"
  key_name      = "deploy"
  access_key    = var.access_key
  secret_access_key = var.secret_access_key
}

output "instance_id" {
  value = module.ec2-instance.instance_id
}

output "instance_public_ip" {
  value = module.ec2-instance.public_ip
}

output "security_group_id" {
  value = module.ec2-instance.security_group_id
}
