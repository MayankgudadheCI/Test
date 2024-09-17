data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")

  vars = {
    bucket_name = var.bucket_name
    object_key  = var.object_key
  }
}

resource "aws_instance" "machine" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.custom.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "Instance-A"
  }
}
