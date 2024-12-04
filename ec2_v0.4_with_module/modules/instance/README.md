<!-- BEGIN_TF_DOCS -->
# Amazon EC2 Instance Terraform module

Terraform module which creates Amazon EC2 Instance resources.

## Examples

See the **/examples** directory for working examples to reference

- [Single EC2 Instance](modules/instance/examples/single-ec2-instance)
- [Multiple EC2 Instances](modules/instance/examples/multiple-ec2-instance)

## Usage

### Single EC2 Instance

```hcl
module "instance_01" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/instance"
  # version   = "~> 4.0"
  source     = "../.."
  depends_on = [module.sg_01]

  name                   = "PTAWSG-5LNG-01"
  ami                    = data.aws_ami.windows_server_2019.image_id # local.ami.WindowsServer2019.id
  instance_type          = "m4.xlarge"
  monitoring             = true
  subnet_id              = data.aws_subnet.alphalng_application-01-az1.id
  iam_instance_profile   = "PTAW_IAC_DEV_AlphaLNG_EC2_PROFILE"
  user_data              = ""
  key_name               = module.keypair_01.key_name
  vpc_security_group_ids = [module.sg_01.this_security_group_id]
  root_block_device = {
    volume_size           = 100
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }
  ebs_block_device = {
    volume_01 = {
      name                  = "DataDisk01"
      device_name           = "/dev/xvdb"
      volume_size           = 70
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
    volume_02 = {
      name                  = "DataDisk02"
      device_name           = "/dev/xvdc"
      volume_size           = 30
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }
  ebs_kms_key   = "arn:aws:kms:ap-southeast-1:054237276863:key/89ff9775-672c-4b12-87cc-6361e7323144"
  ebs_optimized = true
  tags          = {} # No tags needed as tags are provided from the default_tags in the provider
}
```

### Multiple EC2 Instances

```hcl
module "instances" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/instance"
  # version   = "~> 4.0"
  source     = "../.."
  depends_on = [module.sg_01]
  for_each   = toset(["PTAWSG-5LNG-01", "PTAWSG-5LNG-02", "PTAWSG-5LNG-03"])

  name                   = each.key
  ami                    = data.aws_ami.windows_server_2019.image_id # local.ami.WindowsServer2019.id
  instance_type          = "m4.xlarge"
  monitoring             = true
  subnet_id              = data.aws_subnet.alphalng_application-01-az1.id
  iam_instance_profile   = "PTAW_IAC_DEV_AlphaLNG_EC2_PROFILE"
  user_data              = ""
  key_name               = module.keypair_01.key_name
  vpc_security_group_ids = [module.sg_01.this_security_group_id]
  root_block_device = {
    volume_size           = 100
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }
  ebs_block_device = {
    volume_01 = {
      name                  = "DataDisk01"
      device_name           = "/dev/xvdb"
      volume_size           = 70
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
    volume_02 = {
      name                  = "DataDisk02"
      device_name           = "/dev/xvdc"
      volume_size           = 30
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }
  ebs_kms_key   = "arn:aws:kms:ap-southeast-1:054237276863:key/89ff9775-672c-4b12-87cc-6361e7323144"
  ebs_optimized = true
  tags          = {} # No tags needed as tags are provided from the default_tags in the provider
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.primary_eni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | ID of AMI to use for the instance | `string` | `""` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate a public IP address with an instance in a VPC | `bool` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | AZ to start the instance in | `string` | `null` | no |
| <a name="input_capacity_reservation_specification"></a> [capacity\_reservation\_specification](#input\_capacity\_reservation\_specification) | Describes an instance's Capacity Reservation targeting option | `any` | `null` | no |
| <a name="input_cpu_core_count"></a> [cpu\_core\_count](#input\_cpu\_core\_count) | Sets the number of CPU cores for an instance. | `number` | `null` | no |
| <a name="input_cpu_credits"></a> [cpu\_credits](#input\_cpu\_credits) | The credit option for CPU usage (unlimited or standard) | `string` | `null` | no |
| <a name="input_cpu_threads_per_core"></a> [cpu\_threads\_per\_core](#input\_cpu\_threads\_per\_core) | Sets the number of CPU threads per core for an instance (has no effect unless cpu\_core\_count is also set). | `number` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create an instance | `bool` | `true` | no |
| <a name="input_disable_api_stop"></a> [disable\_api\_stop](#input\_disable\_api\_stop) | If true, enables EC2 Instance Stop Protection. | `bool` | `null` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection | `bool` | `null` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | WARNING Stop using ebs\_block\_device, please use submodule volume\_attachment instead! This variable will have no effect due to its vulnerability to drifts. | `map` | `{}` | no |
| <a name="input_ebs_kms_key"></a> [ebs\_kms\_key](#input\_ebs\_kms\_key) | KMS Key id | `string` | `null` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `null` | no |
| <a name="input_enable_volume_tags"></a> [enable\_volume\_tags](#input\_enable\_volume\_tags) | Whether to enable volume tags (if enabled it conflicts with root\_block\_device tags) | `bool` | `true` | no |
| <a name="input_enclave_options_enabled"></a> [enclave\_options\_enabled](#input\_enclave\_options\_enabled) | Whether Nitro Enclaves will be enabled on the instance. Defaults to `false` | `bool` | `null` | no |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | Customize Ephemeral (also known as Instance Store) volumes on the instance | `map` | `{}` | no |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | If true, wait for password data to become available and retrieve it. | `bool` | `null` | no |
| <a name="input_hibernation"></a> [hibernation](#input\_hibernation) | If true, the launched EC2 instance will support hibernation | `bool` | `null` | no |
| <a name="input_host_id"></a> [host\_id](#input\_host\_id) | ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host | `string` | `null` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile | `string` | `null` | no |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance\_initiated\_shutdown\_behavior](#input\_instance\_initiated\_shutdown\_behavior) | Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instance | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `"t3.micro"` | no |
| <a name="input_ipv6_address_count"></a> [ipv6\_address\_count](#input\_ipv6\_address\_count) | A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet | `number` | `null` | no |
| <a name="input_ipv6_addresses"></a> [ipv6\_addresses](#input\_ipv6\_addresses) | Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface | `list(string)` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Specifies a Launch Template to configure the instance. Parameters configured on this resource will override the corresponding parameters in the Launch Template | `any` | `null` | no |
| <a name="input_metadata_options"></a> [metadata\_options](#input\_metadata\_options) | Customize the metadata options of the instance | `map` | `{}` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on EC2 instance created | `string` | `""` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Customize network interfaces to be attached at instance boot time | `list(map(string))` | `[]` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | The Placement Group to start the instance in | `string` | `null` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to associate with the instance in a VPC | `string` | `null` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Customize details about the root block device of the instance. See Block Devices below for details | `any` | `null` | no |
| <a name="input_secondary_private_ips"></a> [secondary\_private\_ips](#input\_secondary\_private\_ips) | A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block` | `list(string)` | `null` | no |
| <a name="input_source_dest_check"></a> [source\_dest\_check](#input\_source\_dest\_check) | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. | `bool` | `true` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to launch in | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_tenancy"></a> [tenancy](#input\_tenancy) | The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host. | `string` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting EC2 instance resources | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| <a name="input_user_data_replace_on_change"></a> [user\_data\_replace\_on\_change](#input\_user\_data\_replace\_on\_change) | When used in combination with user\_data or user\_data\_base64 will trigger a destroy and recreate when set to true. Defaults to false if not set. | `bool` | `false` | no |
| <a name="input_volume_tags"></a> [volume\_tags](#input\_volume\_tags) | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of security group IDs to associate with | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the instance |
| <a name="output_ec2_id"></a> [ec2\_id](#output\_ec2\_id) | The ID of the instance |
| <a name="output_ec2_private_ip"></a> [ec2\_private\_ip](#output\_ec2\_private\_ip) | The private IP address assigned to the instance. |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws\_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached |
| <a name="output_instance_state"></a> [instance\_state](#output\_instance\_state) | The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped` |
| <a name="output_password_data"></a> [password\_data](#output\_password\_data) | Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true |
<!-- END_TF_DOCS -->