# Security Group
module "securitygroup" {
  source = "./modules/securitygroup"

  vpc_id                     = var.vpc_id
  existing_sg_id             = var.existing_sg_id


  tags = var.tags
}

# Key Pair
module "key-pair" {
  source     = "./modules/key-pair"
  use_existing_key = var.use_existing_key
  existing_key_name = var.existing_key_name
  public_key       = var.public_key
  key_pair_name    = var.key_pair_name
  tags             = var.tags 
}

# EC2 Instance
module "instance" {
  source = "./modules/instance"

  create                      = var.create_instance
  name                        = var.instance_name
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [data.aws_security_group.existing_sg.id]
  key_name                    = module.key-pair.key_name
  ebs_optimized               = var.ebs_optimized
  private_ip                  = var.private_ip
  tags                        = var.tags
}

# Volume Attachment
module "volume_attachment" {
  source = "./modules/volume_attachment"

  create_volume              = var.create_volume
  instance_id                = module.instance.ec2_id
  volume_device_name         = var.volume_device_name
  availability_zone          = var.availability_zone
  volume_size                = var.volume_size
  type                       = var.type 
  volume_encrypted           = var.volume_encrypted 
  final_snapshot             = var.final_snapshot
  iops                       = var.iops
  multi_attach_enabled       = var.multi_attach_enabled
  throughput                 = var.throughput
  kms_key_id                 = var.kms_key_id
  snapshot_id                = var.snapshot_id
  //outpost_arn                = var.outpost_arn
  force_detach               = var.force_detach
  skip_destroy               = var.skip_destroy
  stop_instance_before_detaching = var.stop_instance_before_detaching
  tags                       = var.tags
}
