data "aws_vpc" "default" {
  default = true
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")
}