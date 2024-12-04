output "ec2_id" {
  description = "The ID of the instance"
  value       = try(aws_instance.this.id, "")
}

output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.this.arn, "")
}

output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.this.instance_state, "")
}

output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = try(aws_instance.this.password_data, "")
}

output "ec2_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = try(aws_instance.this.public_ip, "")
}

output "ec2_private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.this.private_ip, "")
}
