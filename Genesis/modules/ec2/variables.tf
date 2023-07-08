variable "instance_count" {}
variable "instance_type" {}
variable "volume_count" {}
variable "volume_size" {}
variable "application_name" {}
variable "subnet_id" {}
variable "ami_id" {}
variable "vpc_security_group_ids" {
    type = list(string)
}