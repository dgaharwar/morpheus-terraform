#---------------------------------------------------
# AWS EKS cluster
#---------------------------------------------------

resource "aws_eks_cluster" "eks_cluster" {
  count = var.cluster_enable ? 1 : 0

  name     = var.cluster_name
   role_arn = var.use_existing_role ? var.existing_cluster_role_arn : aws_iam_role.eks_cluster_role[0].arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_groups         = local.security_group_ids
  }

  enabled_cluster_log_types = var.cluster_enabled_cluster_log_types
  version                   = var.cluster_version

  dynamic "encryption_config" {
    iterator = encryption_config
    for_each = var.cluster_encryption_config

    content {
      resources = lookup(encryption_config.value, "resources", null)

      dynamic "provider" {
        iterator = provider
        for_each = length(keys(lookup(encryption_config.value, "provider", {}))) > 0 ? [lookup(encryption_config.value, "provider", {})] : []

        content {
          key_arn = lookup(provider.value, "key_arn", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.cluster_timeouts)) > 0 ? [var.cluster_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge({ Name = var.cluster_name }, var.tags )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [aws_iam_role.eks_cluster_role]
}
