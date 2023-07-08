resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "my-db-subnet-group"
  }
}

resource "aws_db_instance" "my_db_instance" {
  engine             = "mysql"
  engine_version = "5.7"
  instance_class       = "db.t3.medium"
  allocated_storage    = 20
  username             = "foo"
  password             = "foobarbaz"
  storage_type         = "gp2"
  publicly_accessible  = false
  multi_az             = false  # Set to "true" for multi AZ
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = "genesis-db-instance"
  }
}