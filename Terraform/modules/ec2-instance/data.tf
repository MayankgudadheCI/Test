data "aws_vpc" "default" {
  default = true
}
data "template_file" "user_data" {
  template = file("user_data.tpl")
}