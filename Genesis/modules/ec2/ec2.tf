# EC2 instance
resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = var.ami_id 
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

 root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "gp3"
    volume_size = var.volume_size
  }

  ebs_block_device {
    device_name = "/dev/sdc"
    volume_type = "gp3"
    volume_size = var.volume_size
  }

    tags = {
    Name = "${var.application_name}-instance-${count.index}"
  }
}

