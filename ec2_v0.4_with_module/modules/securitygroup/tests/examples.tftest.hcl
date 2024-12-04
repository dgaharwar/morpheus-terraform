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
  mock_data "aws_vpc" {
    defaults = {
      vpc_id = "vpc-0fd75c7a8e10c9e75"
    }
  }
}

run "basic" {
  module {
    source = "./examples/basic"
  }
}
