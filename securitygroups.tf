
/*  Security Group for Instance in VPC-A */
#----------------------------------------------------------------------------#

resource "aws_security_group" "vpcA-sg" {
  name        = "vpcA_instance_SG"
  description = "Allow SSH,HTTP,HTTPS,ICMP"
  vpc_id      = aws_vpc.vpcA.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.vpcB-sg]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block[1]]
    #security_groups = [aws_security_group.vpcB-sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCA_Instance_SG"
  }
}



/*  Security Group for Instance in VPC-B */
#----------------------------------------------------------------------------#

resource "aws_security_group" "vpcB-sg" {
  name        = "vpcB_instance_SG"
  description = "Allow SSH,HTTP,HTTPS,ICMP"
  vpc_id      = aws_vpc.vpcB.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block[0]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCB_Instance_SG"
  }

  provider = aws.other
}

