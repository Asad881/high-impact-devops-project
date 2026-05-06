resource "aws_instance" "Project01_Server" {
  ami = local.server_config.ami
  instance_type = local.server_config.type
  subnet_id = local.server_config.subnet
  key_name = local.server_config.key_name
  vpc_security_group_ids = local.server_config.security_tags
  tags = local.server_config.tags
  user_data = templatefile("${path.module}/setup.sh", {
    image_tag = var.image_tag
  })
  user_data_replace_on_change = true
}