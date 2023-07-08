output "rds_endpoint" {
  value = aws_db_instance.my_db_instance.endpoint
}

output "rds_database_name" {
  value = aws_db_instance.my_db_instance.db_name
}

output "rds_port" {
  value = aws_db_instance.my_db_instance.port
}

output "rds_master_username" {
  value = aws_db_instance.my_db_instance.username
}
