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
}

variable "key_pair_name" {
  description = "The name for the new key pair (if 'use_existing_key' is false)."
  type        = string
  default     = "MorpheusApp"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
