resource "aws_instance" "aws_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  cpu_core_count       = var.cpu_core_count
  cpu_threads_per_core = var.cpu_threads_per_core
  hibernation          = var.hibernation

  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id
  vpc_security_group_ids = compact([
    data.aws_security_group.sg_1.id,
    data.aws_security_group.sg_2.id,
    length(data.aws_security_group.sg_3) > 0 ? data.aws_security_group.sg_3[0].id : null
  ])

  key_name             = var.key_name
  monitoring           = var.monitoring
  get_password_data    = var.get_password_data
  iam_instance_profile = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address
  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_preference != null ? [var.capacity_reservation_preference] : []
    content {
      capacity_reservation_preference = capacity_reservation_specification.value
    }
  }
  credit_specification {
    cpu_credits = var.cpu_credits
  }
  private_ip            = var.private_ip
  secondary_private_ips = var.secondary_private_ips
  ipv6_address_count    = var.ipv6_address_count
  ipv6_addresses        = var.ipv6_addresses

  ebs_optimized = var.ebs_optimized

  root_block_device {
    volume_size           = try(var.root_block_device.volume_size, null)
    volume_type           = try(var.root_block_device.volume_type, null)
    delete_on_termination = try(var.root_block_device.delete_on_termination, false)
    encrypted             = try(var.root_block_device.encrypted, false)
    kms_key_id            = try(var.ebs_kms_key, null)
    iops                  = try(var.root_block_device.iops, null)
    throughput            = try(var.root_block_device.throughput, null)
    # tags                  = merge({ "Name" = "${var.name}-OsDisk" }, var.tags) # will conflict with volume_tags
  }

  # Stop using ebs_block_device, please use submodule volume_attachment instead!!!
  # dynamic "ebs_block_device" {
  #   for_each = var.ebs_block_device
  #   content {
  #     device_name           = ebs_block_device.value.device_name
  #     volume_size           = try(ebs_block_device.value.volume_size, null)
  #     volume_type           = try(ebs_block_device.value.volume_type, null)
  #     delete_on_termination = try(ebs_block_device.value.delete_on_termination, false)
  #     encrypted             = try(ebs_block_device.value.encrypted, false)
  #     kms_key_id            = try(var.ebs_kms_key, null)
  #     iops                  = try(ebs_block_device.value.iops, null)
  #     snapshot_id           = try(ebs_block_device.value.snapshot_id, null)
  #     throughput            = try(ebs_block_device.value.throughput, null)
  #     # tags                  = merge({ "Name" = "${var.name}-${ebs_block_device.value.name}" }, var.tags) # will conflict with volume_tags
  #   }
  # }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = each.value.device_name
      no_device    = each.value.no_device
      virtual_name = each.value.virtual_name
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options
    content {
      http_endpoint               = try(each.value.http_endpoint, "enabled")
      http_tokens                 = try(each.value.http_tokens, "required")
      http_put_response_hop_limit = try(each.value.http_put_response_hop_limit, 3)
      # instance_metadata_tags      = try(each.value.instance_metadata_tags, null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = each.value.device_index
      network_interface_id  = each.value.network_interface_id
      delete_on_termination = each.value.delete_on_termination
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template != null ? [var.launch_template] : []
    content {
      id      = each.value.id
      name    = each.value.name
      version = each.value.version
    }
  }

  enclave_options {
    enabled = var.enclave_options_enabled
  }

  user_data                   = var.user_data
  user_data_base64            = var.user_data_base64
  user_data_replace_on_change = var.user_data_replace_on_change

  source_dest_check                    = length(var.network_interface) > 0 ? null : var.source_dest_check
  disable_api_termination              = var.disable_api_termination
  disable_api_stop                     = var.disable_api_stop
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  placement_group                      = var.placement_group
  tenancy                              = var.tenancy
  host_id                              = var.host_id

  timeouts {
    create = lookup(var.timeouts, "create", null)
    update = lookup(var.timeouts, "update", null)
    delete = lookup(var.timeouts, "delete", null)
  }

  volume_tags = merge({ Name = "${var.name}-Disk" }, local.common_tags)
  tags        = merge({ Name = var.name }, local.common_tags)

  lifecycle {
    ignore_changes = [
      ebs_block_device,
      volume_tags
    ]
  }
}

resource "aws_ec2_tag" "primary_eni" {
  resource_id = aws_instance.aws_instance.primary_network_interface_id
  for_each    = merge({ Name = "${var.name}-PrimaryENI" }, local.common_tags)
  key         = each.key
  value       = each.value
}
