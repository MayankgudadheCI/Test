data "aws_vpc" "default" {
  default = true
}
data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")

  vars = {
    aws_region        = var.region
    bucket_name       = var.bucket_name
    object_key        = "LoginWebApp.war"
    access_key        = var.access_key
    secret_access_key = var.secret_access_key
  }
}
