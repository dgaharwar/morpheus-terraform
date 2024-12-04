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
