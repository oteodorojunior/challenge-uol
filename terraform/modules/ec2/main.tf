resource "aws_instance" "host" {
  count                  = var.number_servers
  ami                    = var.ami
  instance_type          = var.instance_type
  monitoring             = var.monitoring
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name

  tags = {
    Name         = "uol-${var.infra_env}-host"
    Envinronment = "${var.infra_env}"
  }

  root_block_device {
    volume_size = var.volume_size_root
    volume_type = var.volume_type
  }

  ebs_block_device {
    device_name = var.device_name
    volume_size = var.volume_size_ebs_add
    volume_type = var.volume_type
  }
}
