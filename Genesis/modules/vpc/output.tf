output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "Will be used by EC2 Module"
  value = [
    aws_subnet.PublicSubnet1,
    aws_subnet.PublicSubnet2
  ]
}

output "public_subnets_1" {
  description = "Will be used by EC2 Module"
  value = aws_subnet.PublicSubnet1.id

}

output "public_subnets_2" {
  description = "Will be used by EC2 Module "
  value = aws_subnet.PublicSubnet2.id

}
output "private_subnets_1"{
  description = "Will be used by RDS Module "
  value = aws_subnet.PrivateSubnet1.id

}

output "private_subnets_2"{
  description = "Will be used by RDS Module"
  value = aws_subnet.PrivateSubnet2.id

}


output "ec2_security_group" {
  description = "EC2 SG"
  value       = aws_security_group.ec2_security_group.id
}

output "elb_security_group" {
  description = "ELB SG"
  value       = aws_security_group.elb_security_group.id
}

output "rds_security_group"{
  description = "RDS SG"
  value       = aws_security_group.rds_security_group.id
}
