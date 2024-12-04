data "aws_subnet" "alphalng_application-01-az1" {
  id = "subnet-0ab58b74870b39e93"
}

data "aws_ami" "windows_server_2019" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}
