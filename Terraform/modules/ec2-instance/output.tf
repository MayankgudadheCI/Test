output "instance_id" {
  value = aws_instance.machine.id
}

output "public_ip" {
  value = aws_instance.machine.public_ip
}

output "security_group_id" {
  value = aws_security_group.custom.id
}
