output "instance_id" {
  value = aws_instance.machine.id
}

output "instance_public_ip" {
  value = aws_instance.machine.public_ip
}
