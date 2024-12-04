data "aws_key_pair" "existing_key" {
  count    = var.use_existing_key ? 1 : 0
  key_name = var.existing_key_name
}

resource "aws_key_pair" "new_key_pair" {
  count      = var.use_existing_key ? 0 : 1
  key_name   = var.key_pair_name
  public_key = var.public_key
  tags       = local.common_tags
}