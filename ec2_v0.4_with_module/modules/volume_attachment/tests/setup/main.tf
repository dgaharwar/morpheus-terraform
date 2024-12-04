data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "random_string" "random_id" {
  length  = 6
  special = false
  upper   = false
}

locals {
  random_id = random_string.random_id.id
}

module "ec2" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/instance"
  # version   = "~> 4.0"
  source = "../../../instance"

  name                   = "test-ebs-instance-${local.random_id}"
  ami                    = data.aws_ami.amazon_linux.image_id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.test.id
  vpc_security_group_ids = [aws_security_group.test.id]
  root_block_device = {
    volume_size           = 100
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = false # for testing purpose only!!
  }

  ebs_optimized = true

  ebs_block_device = [
    {
      device_name           = "/dev/sdf"
      volume_size           = 1
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = false # for testing purpose only!!
    }
  ]
}

################################################################################
# Supporting Resources
################################################################################
resource "aws_vpc" "test" {
  cidr_block = "9.9.9.0/24"
  tags = {
    Name = "test-vpc-${local.random_id}"
  }
}

resource "aws_subnet" "test" {
  vpc_id            = aws_vpc.test.id
  availability_zone = "ap-southeast-1a"
  cidr_block        = "9.9.9.0/28"
  tags = {
    Name = "test-subnet-1a-${local.random_id}"
  }
}

resource "aws_security_group" "test" {
  name   = "test-db-sg-${local.random_id}"
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "test-sg-${local.random_id}"
  }
}

################################################################################
# Outputs
################################################################################
output "ec2_instance_id" {
  description = "The EC2 instance id for testing"
  value       = module.ec2.ec2_id
}
