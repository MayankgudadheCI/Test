
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_access_key
  region     = var.region
}

module "ec2-instance" {
  source             = "./modules/ec2-instance"
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  access_key         = var.access_key
  secret_access_key =  var.secret_access_key
}

output "instance_id" {
  value = module.ec2-instance.instance_id
}

output "instance_public_ip" {
  value = module.ec2-instance.public_ip
}