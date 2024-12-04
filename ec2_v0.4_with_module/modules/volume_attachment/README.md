<!-- BEGIN_TF_DOCS -->
# AWS Volume Attachment Terraform module

Terraform module which creates and attaches new volume to an EC2 server.

## Examples

See the **/examples** directory for working examples to reference

- [Complete](modules/volume_attachment/examples/complete)

## Usage

### Complete

```hcl
module "instance_01" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/instance"
  # version   = "~> 4.0"
  source     = "../../../instance"
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

  # It is recommended not to use arguement "ebs_block_device" as it conflicts with resource "aws_volume_attachment" as it causes a drift when use side by side. 
  # For more reference, refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment

  ebs_kms_key   = "arn:aws:kms:ap-southeast-1:054237276863:key/89ff9775-672c-4b12-87cc-6361e7323144"
  ebs_optimized = true
  tags          = {} # No tags needed as tags are provided from the default_tags in the provider
}

module "volume_attachment" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/volume_attachment"
  # version   = "~> 4.0"
  source                         = "../.."
  device_name                    = "/dev/sdh"
  instance_id                    = module.instance_01.ec2_id
  force_detach                   = false
  skip_destroy                   = false
  stop_instance_before_detaching = false

  availability_zone = "ap-southeast-1a"
  size              = 200
  type              = "gp3"
  encrypted         = true
  kms_key_id        = "arn:aws:kms:ap-southeast-1:054237276863:key/89ff9775-672c-4b12-87cc-6361e7323144"
  tags              = {} # No tags needed as tags are provided from the default_tags in the provider
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
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Required) The AZ where the EBS volume will exist. | `any` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create a new volume. | `bool` | `true` | no |
| <a name="input_device_name"></a> [device\_name](#input\_device\_name) | (Required) The device name to expose to the instance (for example, /dev/sdh or xvdh). Read more about [device names on Linux instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html) and [on Windows instances](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/device_naming.html) | `any` | n/a | yes |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | If true, snapshot will be created before volume deletion. | `bool` | `true` | no |
| <a name="input_final_snapshot"></a> [final\_snapshot](#input\_final\_snapshot) | If true, the disk will be encrypted. | `bool` | `true` | no |
| <a name="input_force_detach"></a> [force\_detach](#input\_force\_detach) | (Optional) Set to true if you want to force the volume to detach, using that can result in data loss. | `bool` | `false` | no |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | (Required) ID of the Instance to attach to | `any` | n/a | yes |
| <a name="input_iops"></a> [iops](#input\_iops) | (Optional) The amount of IOPS to provision for the disk. Only valid for type of io1, io2 or gp3. | `any` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) The ARN for the KMS encryption key. When specifying kms\_key\_id, encrypted needs to be set to true. | `any` | `null` | no |
| <a name="input_multi_attach_enabled"></a> [multi\_attach\_enabled](#input\_multi\_attach\_enabled) | (Optional) Specifies whether to enable Amazon EBS Multi-Attach. Multi-Attach is supported on io1 and io2 volumes. | `bool` | `false` | no |
| <a name="input_outpost_arn"></a> [outpost\_arn](#input\_outpost\_arn) | (Optional) The Amazon Resource Name (ARN) of the Outpost. | `any` | `null` | no |
| <a name="input_size"></a> [size](#input\_size) | (Required) The size of the drive in GiBs. | `any` | n/a | yes |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | (Optional) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached. | `bool` | `false` | no |
| <a name="input_snapshot_id"></a> [snapshot\_id](#input\_snapshot\_id) | (Optional) A snapshot to base the EBS volume off of. | `any` | `null` | no |
| <a name="input_stop_instance_before_detaching"></a> [stop\_instance\_before\_detaching](#input\_stop\_instance\_before\_detaching) | (Optional) Set this to true to ensure that the target instance is stopped before trying to detach the volume. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. If default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_throughput"></a> [throughput](#input\_throughput) | (Optional) The throughput that the volume supports, in MiB/s. Only valid for type of gp3. | `any` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_device_name"></a> [device\_name](#output\_device\_name) | The device name exposed to the instance |
| <a name="output_volume_arn"></a> [volume\_arn](#output\_volume\_arn) | ARN of the Volume |
| <a name="output_volume_id"></a> [volume\_id](#output\_volume\_id) | ID of the Volume |
<!-- END_TF_DOCS -->
