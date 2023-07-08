output "private_ips" {
  value = aws_instance.ec2_instance[*].private_ip
}

output "private_ids" {
    value = aws_instance.ec2_instance[*].id
}