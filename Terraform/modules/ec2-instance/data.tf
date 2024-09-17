data "aws_vpc" "default" {
  default = true
}
data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")

  vars = {
    aws_region        = ap-south-1
    bucket_name       = deploy-mayank-mumbai
    object_key        = LoginWebApp
    access_key        = var.access_key
    secret_access_key = var.secret_access_key
  }
}
