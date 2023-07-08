resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name    = "vpc"
    Project = "Genesis_challenge"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "ec2 sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict the source IP if desired
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb_security_group" {
  name        = "elb-security-group"
  description = "elb sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443  
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "RDS security group description"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_security_group.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "IGW"
    Project = "Genesis_challenge"
  }
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name    = "PublicSubnet1"
    Project = "Genesis_challenge"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name    = "PublicSubnet2"
    Project = "Genesis_challenge"
  }
}
resource "aws_subnet" "PrivateSubnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "PrivateSubnet1"
    Project = "Genesis_challenge"
  }
}

resource "aws_subnet" "PrivateSubnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "PrivateSubnet2"
    Project = "Genesis_challenge"
  }
}

resource "aws_route_table" "PrivateRT1" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "PrivateRT1"
    Project = "Genesis_challenge"
  }
}

resource "aws_route_table" "PrivateRT2" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "PrivateRT2"
    Project = "Genesis_challenge"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name    = "PublicRT"
    Project = "Genesis_challenge"
  }
}

resource "aws_route_table_association" "PrivateRTassociation1" {
  subnet_id      = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.PrivateRT1.id
}

resource "aws_route_table_association" "PrivateRTassociation2" {
  subnet_id      = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.PrivateRT2.id
}

resource "aws_route_table_association" "PublicRTassociation1" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRT.id
}
resource "aws_route_table_association" "PublicRTassociation2" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.PublicRT.id
}