resource "aws_security_group" "custom" {
  name        = "custom-security-group"
  description = "Custom security group in the default VPC"
  vpc_id      = data.aws_vpc.default.id

  # Ingress rules
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom-security-group"
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

