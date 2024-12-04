######################################################################################################
# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# This AWS Content is provided subject to the terms of the AWS Customer Agreement available at
# http://aws.amazon.com/agreement or other written agreement between Customer and either
# Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.
#######################################################################################################

# provider "aws" {
#   region = "ap-southeast-1"
# }

mock_provider "aws" {
  mock_data "aws_subnet" {
    defaults = {
      id = "mock_subnet_id"
    }
  }

  mock_data "aws_ami" {
    defaults = {
      image_id = "ami-mock_image_id"
    }
  }
}

run "single" {
  module {
    source = "./../instance/examples/single-ec2-instance"
  }
}

run "multiple" {
  module {
    source = "./../instance/examples/multiple-ec2-instance"
  }
}
