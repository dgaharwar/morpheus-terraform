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
