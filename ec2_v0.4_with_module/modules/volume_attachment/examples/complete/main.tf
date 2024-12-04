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


