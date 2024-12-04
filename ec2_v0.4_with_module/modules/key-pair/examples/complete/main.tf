/*
module "keypair_01" {
  # source    = "aws.tfe.petronas.com/PTAW-IAC-NLZ/ec2/aws//modules/key-pair"
  # version   = "~> 4.0"
  source     = "../.."
  key_name   = "PTAWSG-IAC-DEV-AlphaLNG-EC2-KeyPair"
  public_key = file("${path.module}/key.pub")
  tags       = { Name = "PTAWSG-IAC-DEV-AlphaLNG-EC2-KeyPair" }
}
*/
