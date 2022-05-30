### Variables EC2

variable "ami" {
  type        = string
  description = "To use Ubuntu Specific"
}

variable "instance_type" {
  type        = string
  description = "Type to ec2"
}

variable "monitoring" {
  type        = bool
  description = "Active monitoring in the host"
}

variable "number_servers" {
  type        = number
  description = "Number of servers"
}

variable "infra_env" {
  type        = string
  description = "Envinronment Infra"
}

variable "subnet_id" {
  type        = string
  description = "Subnet private"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Id vpc"
}

variable "key_name" {
  type        = string
  description = "ID sg VPC"
}

variable "volume_size_root" {
  type        = number
  description = "Size of ebs to root "
}

variable "volume_size_ebs_add" {
  type        = number
  description = "Size of ebs to adicional "
}

variable "volume_type" {
  type        = string
  description = "Type of volume"
}

variable "device_name" {
  type        = string
  description = "Point mount of the ebs"
}