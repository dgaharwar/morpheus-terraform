<!-- BEGIN_TF_DOCS -->
# Amazon EC2 Terraform module

Terraform module which creates Amazon EC2 resources.

> [!WARNING]  
> This module contains multiple submodules, and does not contain a module in the root directory.

Please find the following modules in its subdirectories.

- [instance](modules/instance) (modules/instance)
- [key-pair](modules/key-pair) (modules/key-pair)
- [securitygroup](modules/securitygroup) (modules/securitygroup)
- [volume-attachment](modules/volume_attachment) (modules/volume_attachment)

## Examples

See the **/examples** directory for working examples to reference.

To reference a submodule within a module. Please use the `//` in the `source` parameter in a module block.

- [Single EC2 instance](modules/instance/examples/single-ec2-instance)
- [Multiple EC2 instances](modules/instance/examples/multiple-ec2-instance)
- [Basic Security Group](modules/securitygroup/examples/basic)
- [Key Pair](modules/key-pair/examples/complete)
- [Volume Attachment](odules/volume_attachment/examples/complete)

## Usage

### Single EC2 instance

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

### Multiple EC2 instances

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

### Basic Security Group

```hcl
module "sg_01" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/securitygroup"
  # version   = "~> 4.0"
  source      = "../.."
  name        = "PTAWSG-IAC-DEV-AlphaLNG-PG1-DB-SG"
  description = "AlphaLNG DEV PostgreSQL1 Security Group"
  vpc_id      = "vpc-0fd75c7a8e10c9e75"
  ingress_with_cidr_blocks = [
    {
      from_port   = "5432"
      to_port     = "5432"
      protocol    = "tcp"
      description = "RDS access on 5432"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      from_port   = "5432"
      to_port     = "5432"
      protocol    = "tcp"
      description = "RDS access on 5432 from Azure"
      cidr_blocks = "172.0.0.0/8"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "All traffic outbound rule"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = { Name = "PTAWSG-IAC-DEV-AlphaLNG-PG1-DB-SG" }
}
```

### Key Pair

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

### Volume Attachment

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
<!-- END_TF_DOCS -->
