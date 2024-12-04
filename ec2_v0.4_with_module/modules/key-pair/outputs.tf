output "key_name" {
  value = var.use_existing_key ? data.aws_key_pair.existing_key[0].key_name : aws_key_pair.new_key_pair[0].key_name
}