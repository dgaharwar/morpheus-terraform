output "security_group_ids" {
  description = "The IDs of the security groups in use."
  value = compact([
    data.aws_security_group.sg_1.id,
    data.aws_security_group.sg_2.id,
    length(data.aws_security_group.sg_3) > 0 ? data.aws_security_group.sg_3[0].id : null
  ])
}

output "security_group_names" {
  description = "The names of the security groups in use."
  value = compact([
    data.aws_security_group.sg_1.name,
    data.aws_security_group.sg_2.name,
    length(data.aws_security_group.sg_3) > 0 ? data.aws_security_group.sg_3[0].name : null
  ])
}

output "security_group_descriptions" {
  description = "The descriptions of the security groups in use."
  value = compact([
    data.aws_security_group.sg_1.description,
    data.aws_security_group.sg_2.description,
    length(data.aws_security_group.sg_3) > 0 ? data.aws_security_group.sg_3[0].description : null
  ])
}

output "security_group_vpc_ids" {
  description = "The VPC IDs associated with the security groups."
  value = compact([
    data.aws_security_group.sg_1.vpc_id,
    data.aws_security_group.sg_2.vpc_id,
    length(data.aws_security_group.sg_3) > 0 ? data.aws_security_group.sg_3[0].vpc_id : null
  ])
}


########################################

# Volume Attachment Output

########################################

output "device_name" {
  description = "The device name exposed to the instance"
  value       = try(aws_volume_attachment.this[0].device_name, null)
}

output "volume_id" {
  description = "ID of the Volume"
  value       = try(aws_ebs_volume.this[0].id, null)
}

output "volume_arn" {
  description = "ARN of the Volume"
  value       = try(aws_ebs_volume.this[0].arn, null)
}

########################################

# Keypair Output

########################################

output "key_name" {
  value = var.use_existing_key ? data.aws_key_pair.existing_key[0].key_name : aws_key_pair.new_key_pair[0].key_name
}

########################################

# EC2 Instance Output

########################################

output "ec2_id" {
  description = "The ID of the instance"
  value       = try(aws_instance.aws_instance.id, "")
}

output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.aws_instance.arn, "")
}

output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.aws_instance.instance_state, "")
}

output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = try(aws_instance.aws_instance.password_data, "")
}

output "ec2_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = try(aws_instance.aws_instance.public_ip, "")
}

output "ec2_private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.aws_instance.private_ip, "")
}

