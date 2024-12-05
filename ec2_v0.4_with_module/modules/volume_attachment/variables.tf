variable "instance_id" {
  description = "(Required) ID of the Instance to attach to"
}

variable "volume_device_name" {
  description = "(Required) The device name to expose to the instance (for example, /dev/sdh or xvdh). Read more about [device names on Linux instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html) and [on Windows instances](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/device_naming.html)"
  default     = "/dev/xvdf"
}

variable "availability_zone" {
  description = "(Required) The AZ where the EBS volume will exist."
  default     = "us-east-1f"
}

variable "volume_size" {
  description = "(Required) The size of the drive in GiBs."
  default     = 10
}

variable "type" {
  description = "(Required) The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1."
  default     = gp2

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "sc1", "st1"], var.type)
    error_message = "Valid values for var.type gp2, gp3, io1, io2, sc1, or st1."
  }
}

variable "create_volume" {
  description = "Whether to create a new volume."
  type        = bool
  default     = true
}

variable "volume_encrypted" {
  description = "If true, snapshot will be created before volume deletion."
  type        = bool
  default     = true
}

variable "final_snapshot" {
  description = "If true, the disk will be encrypted."
  type        = bool
  default     = true
}

variable "iops" {
  description = "(Optional) The amount of IOPS to provision for the disk. Only valid for type of io1, io2 or gp3."
  default     = null
}

variable "multi_attach_enabled" {
  description = "(Optional) Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on io1 and io2 volumes."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true."
  default     = null
}

variable "throughput" {
  description = "(Optional) The throughput that the volume supports, in MiB/s. Only valid for type of gp3."
  default     = null
}

variable "snapshot_id" {
  description = "(Optional) A snapshot to base the EBS volume off of."
  default     = null
}

variable "outpost_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the Outpost."
  default     = null
}

variable "force_detach" {
  description = "(Optional) Set to true if you want to force the volume to detach, using that can result in data loss."
  type        = bool
  default     = false
}

variable "skip_destroy" {
  description = "(Optional) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached."
  type        = bool
  default     = false
}

variable "stop_instance_before_detaching" {
  description = "(Optional) Set this to true to ensure that the target instance is stopped before trying to detach the volume."
  type        = bool
  default     = true
}


variable "tags" {
  description = "A mapping of tags to assign to the resource. If default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}
