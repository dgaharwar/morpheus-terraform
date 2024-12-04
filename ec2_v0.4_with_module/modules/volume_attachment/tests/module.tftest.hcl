provider "aws" {
  region = "ap-southeast-1"
}

// Create temporary kms key for testing purposes and get caller accountid
run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "attach_ebs_to_running_ec2" {
  command = apply

  variables {
    device_name                    = "/dev/sdg"
    instance_id                    = run.setup.ec2_instance_id
    force_detach                   = false
    skip_destroy                   = false # for testing purpose only!!
    stop_instance_before_detaching = false

    availability_zone = "ap-southeast-1a"
    size              = 1
    type              = "gp3"
    encrypted         = false # for testing purpose only!!
  }

  assert {
    condition     = output.volume_id != null
    error_message = "EBS volume failed to create"
  }

  assert {
    condition     = output.device_name != null
    error_message = "EBS volume failed to attach to the EC2 instance"
  }
}
