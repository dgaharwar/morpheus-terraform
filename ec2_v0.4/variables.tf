variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "aws_region" {
  description = "The region where to deploy this code (e.g. us-east-1)."

}

# Instance Variables
variable "create_instance" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = ""
}

/*
  variable "instance_name" {
    description = "Name for the EC2 instance"
    type        = string
  }
*/

variable "ami" {
  description = "ID of the AMI to use for the instance"
  type        = string
  default     = "ami-0866a3c8686eaeeba"
}


variable "associate_public_ip_address" {
  description = "Whether to associate a public IP"
  type        = bool
  default     = false
}

/*
variable "capacity_reservation_specification" {
  description = "Describes an instance's Capacity Reservation targeting option"
  type        = any
  default     = null
}
*/

variable "capacity_reservation_preference" {
  description = "The instance's capacity reservation preference ('open', 'none', or null for default behavior)"
  type        = string
  default     = null
}


variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = null
}
variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "AZ for the EC2 instance"
  type        = string
  default     = "us-east-1f"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
  default     = "subnet-ed6462e3"
}

variable "private_ip" {
  description = "Private IP for the EC2 instance"
  type        = string
  default     = null
}

variable "ebs_optimized" {
  description = "Enable EBS optimization"
  type        = bool
  default     = false
}

variable "ebs_kms_key" {
  description = "KMS Key id"
  type        = string
  default     = null
}

variable "enclave_options_enabled" {
  description = "Whether Nitro Enclaves will be enabled on the instance. Defaults to `false`"
  type        = bool
  default     = null
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = {}
}

variable "get_password_data" {
  description = "If true, wait for password data to become available and retrieve it."
  type        = bool
  default     = false
}

variable "hibernation" {
  description = "If true, the launched EC2 instance will support hibernation"
  type        = bool
  default     = false
}

variable "host_id" {
  description = "ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  type        = string
  default     = null
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  type        = number
  default     = null
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "launch_template" {
  description = "Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template"
  default     = null
}

variable "metadata_options" {
  description = "Customize the metadata options of the instance"
  default     = {}
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = null
}

variable "secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block`"
  type        = list(string)
  default     = null
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  type        = string
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "When used in combination with user_data or user_data_base64 will trigger a destroy and recreate when set to true. Defaults to false if not set."
  type        = bool
  default     = false
}

variable "enable_volume_tags" {
  description = "Whether to enable volume tags (if enabled it conflicts with root_block_device tags)"
  type        = bool
  default     = true
}

/*
variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)

}
*/
variable "security_group_1" {
  description = "The first security group ID"
  type        = string
  default     = "sg-2b299333"
}

variable "security_group_2" {
  description = "The second security group ID"
  type        = string
  default     = "sg-0779acbd76ea35a65"
}

variable "security_group_3" {
  description = "The optional third security group ID"
  type        = string
  default     = "sg-0e0b8738d4850ea19"
}

data "aws_security_group" "sg_1" {
  id = var.security_group_1
}

data "aws_security_group" "sg_2" {
  id = var.security_group_2
}

data "aws_security_group" "sg_3" {
  count = var.security_group_3 != null ? 1 : 0
  id    = var.security_group_3
}



variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type        = map(string)
  default     = {}
}

variable "cpu_core_count" {
  description = "Sets the number of CPU cores for an instance." # This option is only supported on creation of instance type that support CPU Options https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html#cpu-options-supported-instances-values
  type        = number
  default     = 1
}

variable "cpu_threads_per_core" {
  description = "Sets the number of CPU threads per core for an instance (has no effect unless cpu_core_count is also set)."
  type        = number
  default     = 1
}

variable "disable_api_stop" {
  description = "If true, enables EC2 Instance Stop Protection."
  type        = bool
  default     = false
}



# Key Pair Variables
variable "use_existing_key" {
  description = "Set to true to use an existing key pair, or false to create a new one."
  type        = bool
  default     = true
}

variable "existing_key_name" {
  description = "The name of the existing key pair to use (if 'use_existing_key' is true)."
  type        = string
  default     = "MorpheusApp"
}

variable "public_key" {
  description = "The public key material to create a new key pair (if 'use_existing_key' is false)."
  type        = string
  default     = ""
}

variable "key_pair_name" {
  description = "The name for the new key pair (if 'use_existing_key' is false)."
  type        = string
  default     = ""
}

# Security Group Variables
/*
variable "existing_sg_id" {
  description = "The ID of the existing security group to use if 'use_existing_sg' is true."
  type        = string
  default     = ""
}
*/

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
  default     = "vpc-33ac354e"
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

# Volume Variables
variable "create_volume" {
  description = "Whether to create a volume"
  type        = bool
  default     = true
}

/*
variable "instance_id" {
  description = "(Required) ID of the Instance to attach to"
}
*/

variable "volume_device_name" {
  description = "Device name for the volume"
  type        = string
  default     = "/dev/xvdf"
}

variable "volume_size" {
  description = "Size of the volume in GB"
  type        = number
  default     = 10
}

variable "type" {
  description = "Type of the volume (gp2, gp3, io1, etc.)"
  type        = string
  default     = "gp2"
}

variable "volume_encrypted" {
  description = "Whether to encrypt the volume"
  type        = bool
  default     = true
}

variable "final_snapshot" {
  description = "Whether to create a final snapshot before deletion"
  type        = bool
  default     = true
}

variable "iops" {
  description = "IOPS for the volume"
  type        = number
  default     = null
}

variable "multi_attach_enabled" {
  description = "(Optional) Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on io1 and io2 volumes."
  type        = bool
  default     = false
}

variable "throughput" {
  description = "Throughput for the volume (gp3 only)"
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "KMS key ID for volume encryption"
  type        = string
  default     = null
}

variable "snapshot_id" {
  description = "Snapshot ID for volume creation"
  type        = string
  default     = null
}

variable "outpost_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the Outpost."
  default     = null
}

variable "force_detach" {
  description = "Force detach the volume"
  type        = bool
  default     = false
}

variable "skip_destroy" {
  description = "Skip destroy for the volume"
  type        = bool
  default     = false
}

variable "stop_instance_before_detaching" {
  description = "Stop instance before detaching volume"
  type        = bool
  default     = true
}

## Tags

variable "Project_Code" {
  description = "Project Code associated with the deployment"
  type        = string
  default     = "03703"
}

variable "ApplicationId" {
  description = "Application ID for the project"
  type        = string
  default     = "ALPHA"
}

variable "ApplicationName" {
  description = "Name of the Application"
  type        = string
  default     = "ALPHA"
}

variable "environment" {
  description = "Deployment environment (e.g., Production, Staging)"
  type        = string
  default     = "Production"
}

variable "CostCenter" {
  description = "Cost Center for the project"
  type        = string
  default     = "001PXXX12"
}

variable "DataClassification" {
  description = "Data Classification level"
  type        = string
  default     = "Confidential"
}

variable "SCAClassification" {
  description = "SCA Classification level"
  type        = string
  default     = "Standard"
}

variable "IACRepo" {
  description = "Infrastructure as Code repository URL"
  type        = string
  default     = ""
}

variable "ProductOwner" {
  description = "Email of the Product Owner"
  type        = string
  default     = "user@petronas.com"
}

variable "ProductSupport" {
  description = "Email of the Product Support"
  type        = string
  default     = "user@petronas.com"
}

variable "BusinessOwner" {
  description = "Email of the Business Owner"
  type        = string
  default     = "user@petronas.com"
}

variable "CSBIA_Availability" {
  description = "CSBIA Availability level"
  type        = string
  default     = "Moderate"
}

variable "CSBIA_Confidentiality" {
  description = "CSBIA Confidentiality level"
  type        = string
  default     = "Major"
}

variable "CSBIA_ImpactScore" {
  description = "CSBIA Impact Score"
  type        = string
  default     = "Major"
}

variable "CSBIA_Integrity" {
  description = "CSBIA Integrity level"
  type        = string
  default     = "Moderate"
}

variable "BusinessOPU_HCU" {
  description = "Business OPU/HCU associated with the project"
  type        = string
  default     = "GTS"
}

variable "BusinessStream" {
  description = "Business Stream associated with the project"
  type        = string
  default     = "PDnT"
}

variable "SRNumber" {
  description = "Service Request Number"
  type        = string
  default     = "REQ000006277983"
}



