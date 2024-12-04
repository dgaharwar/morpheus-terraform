################################################################################################################################################################################################################################################
# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# This AWS Content is provided subject to the terms of the AWS Customer Agreement available at
# http://aws.amazon.com/agreement or other written agreement between Customer and either
# Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.
################################################################################################################################################################################################################################################

# Attaches the new EBS volume to the EC2 instance
resource "aws_volume_attachment" "this" {
  count = var.create_volume ? 1 : 0

  device_name                    = var.volume_device_name
  volume_id                      = aws_ebs_volume.this[0].id
  instance_id                    = var.instance_id
  force_detach                   = var.force_detach
  skip_destroy                   = var.skip_destroy
  stop_instance_before_detaching = var.stop_instance_before_detaching
}

# Creates a new EBS volume for EC2 attachment
resource "aws_ebs_volume" "this" {
  count = var.create_volume ? 1 : 0

  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.type
  encrypted         = var.volume_encrypted
  kms_key_id        = var.kms_key_id

  # Snapshot volume
  final_snapshot = var.final_snapshot
  snapshot_id    = var.snapshot_id

  # Optional inputs
  iops                 = var.iops
  throughput           = var.throughput
  multi_attach_enabled = var.multi_attach_enabled
  outpost_arn          = var.outpost_arn

  tags = merge({ Name = "${var.instance_id}-Disk" }, var.tags)
}
