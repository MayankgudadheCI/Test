variable "access_key" {}
variable "secret_access_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_access_key
  region     = "ap-south-1"
}
resource "aws_instance" "machine" {
  ami             = "ami-0d1e92463a5acf79d"
  instance_type   = "t2.micro"
  key_name        = "deploy"

  tags = {
    Name = "Instance-A"
  }
}



