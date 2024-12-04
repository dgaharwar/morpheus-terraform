<!-- BEGIN_TF_DOCS -->
# AWS Key Pair Terraform module

Terraform module which creates AWS Key Pair resources.

## Examples

See the **/examples** directory for working examples to reference

- [Complete](modules/key-pair/examples/complete)

## Usage

### Complete

```hcl
module "keypair_01" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/key-pair"
  # version   = "~> 4.0"
  source     = "../.."
  key_name   = "PTAWSG-IAC-DEV-AlphaLNG-EC2-KeyPair"
  public_key = file("${path.module}/key.pub")
  tags       = { Name = "PTAWSG-IAC-DEV-AlphaLNG-EC2-KeyPair" }
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
| [aws_key_pair.ec2_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name for the key pair | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key material | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | Key Name |
<!-- END_TF_DOCS -->