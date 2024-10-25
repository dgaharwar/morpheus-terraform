#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


variable "region" {}
variable "access_key" {}
variable "secret_key" {}

variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# AWS EKS cluster
#-----------------------------------------------------------
variable "cluster_enable" {
  description = "Enable creating AWS EKS cluster"
  default     = true
}

variable "cluster_name" {
  description = "Custom name of the cluster."
  default     = "eks_tf"
}

variable "cluster_enabled_cluster_log_types" {
  description = "(Optional) A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging"
  default     = []
}

variable "cluster_version" {
  description = "(Optional) Desired Kubernetes master version. If you do not specify a value, the latest available version at resource creation is used and no upgrades will occur except those automatically triggered by EKS. The value must be configured and increased to upgrade the version when desired. Downgrades are not supported by EKS."
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default     = ["subnet-37efa251","subnet-37a1ea16"]
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = ["sg-2b299333","sg-0dfa7b8de2b65bb4c"]
}
     
#locals {
#  security_groups = split(",", var.security_group_ids)
#}

variable "cluster_encryption_config" {
  description = "(Optional) Configuration block with encryption configuration for the cluster. Only available on Kubernetes 1.13 and above clusters created after March 6, 2020."
  default     = []
}

variable "cluster_timeouts" {
  description = "Set timeouts for EKS cluster"
  default     = {}
}

#---------------------------------------------------
# AWS EKS fargate profile
#---------------------------------------------------
variable "fargate_profile_enable" {
  description = "Enable EKS fargate profile usage"
  default     = false
}

variable "fargate_profile_name" {
  description = "Name of the EKS Fargate Profile."
  default     = ""
}

variable "fargate_profile_cluster_name" {
  description = "Name of the EKS Cluster."
  default     = ""
}

variable "fargate_profile_pod_execution_role_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Fargate Profile."
  default     = ""
}

variable "fargate_profile_subnet_ids" {
  description = "(Required) Identifiers of private EC2 Subnets to associate with the EKS Fargate Profile. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
  default     = []
}

variable "fargate_profile_selector" {
  description = "(Required) Configuration block(s) for selecting Kubernetes Pods to execute with this EKS Fargate Profile. "
  default     = []
}

variable "fargate_profile_timeouts" {
  description = "Set timeouts for EKS fargate profile"
  default     = {}
}

#---------------------------------------------------
# AWS EKS node group
#---------------------------------------------------
variable "node_group_enable" {
  description = "Enable EKS node group usage"
  default     = true
}

variable "node_group_name" {
  description = "Name of the EKS Node Group."
  default     = "eks_tf_group"
}

variable "node_group_cluster_name" {
  description = "Name of the EKS Cluster."
  default     = "eks_tf"
}

variable "node_group_subnet_ids" {
  description = "(Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
  type        = list(string)  
  default     = ["subnet-37efa251","subnet-37a1ea16"]
}

variable "node_group_scaling_config" {
  description = ""
  default = [
    {
      max_size     = 1
      desired_size = 1
      min_size     = 1
    }
  ]
}

variable "node_group_ami_type" {
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU. Terraform will only perform drift detection if a configuration value is provided."
  default     = "AL2_x86_64"
}

variable "node_group_disk_size" {
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20. Terraform will only perform drift detection if a configuration value is provided."
  default     = 20
}

variable "node_group_force_update_version" {
  description = "(Optional) Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  default     = null
}

variable "node_group_instance_types" {
  description = "(Optional) Set of instance types associated with the EKS Node Group. Defaults to ['t3.medium']. Terraform will only perform drift detection if a configuration value is provided. Currently, the EKS API only accepts a single value in the set."
  type        = list(string)
  default     = ["t3.medium"]  // Default value as a list
}

variable "node_group_labels" {
  description = "(Optional) Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed."
  type        = map(string)
  default     = {}
}

variable "node_group_release_version" {
  description = "(Optional) AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
  default     = null
}

variable "node_group_version" {
  description = "(Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  default     = null
}

variable "node_group_remote_access" {
  description = "(Optional) Configuration block with remote access settings."
  default     = []
}

variable "node_group_launch_template" {
  description = "(Optional) Configuration block with Launch Template settings."
  default     = []
}

variable "node_group_timeouts" {
  description = "Set timeouts for EKS node group"
  default     = {}
}
##### New Variables for cluster and node_group role

variable "use_existing_role" {
  description = "Flag to determine if existing role ARN should be used"
  type        = bool
  default     = false
}

variable "existing_cluster_role_arn" {
  description = "Existing cluster role ARN"
  type        = string
  default     = ""
}

variable "existing_node_group_role_arn" {
  description = "Existing node group role ARN"
  type        = string
  default     = ""
}

variable "new_role_name" {
  description = "The name of the new IAM role if creating new roles"
  type        = string
  default     = "eks-tf-role"
}

variable "node_group_max_size" {
  description = "The maximum number of nodes for the EKS node group"
  type        = number
  default     = 3

}

variable "node_group_desired_size" {
  description = "The desired number of nodes for the EKS node group"
  type        = number
  default     = 2

}

variable "node_group_min_size" {
  description = "The minimum number of nodes for the EKS node group"
  type        = number
  default     = 2
}

