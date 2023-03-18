// CALLER ID FOR ACCEPTER
data "aws_caller_identity" "id-accepter" {
  provider = aws.other
}



// VPC Peering Connection - created on requester
resource "aws_vpc_peering_connection" "vpcA-B" {
  vpc_id        = aws_vpc.vpcA.id
  peer_vpc_id   = aws_vpc.vpcB.id
  peer_owner_id = data.aws_caller_identity.id-accepter.account_id
  peer_region = "us-east-2"
  auto_accept = false

#   accepter {
#     allow_remote_vpc_dns_resolution = true
#   }

#   requester {
#     allow_remote_vpc_dns_resolution = true
#   }

#   depends_on = [
#     aws_vpc.vpcA, aws_vpc.vpcB
#   ]

    tags = {
        Side = "Requester"
    }
}



// ACCEPTER
resource "aws_vpc_peering_connection_accepter" "vpc-B-accepter" {
  provider = aws.other

  vpc_peering_connection_id = aws_vpc_peering_connection.vpcA-B.id
  auto_accept               = true

  tags = {
    Side = "VPC-B-Accepter"
  }
}



// OPTION - requester 
resource "aws_vpc_peering_connection_options" "vpcA-requester-options" {
  # As options can't be set until the connection has been accepted
  # create an explicit dependency on the accepter.
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.vpc-B-accepter.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}



//OPTION 2
resource "aws_vpc_peering_connection_options" "vpcB-accepter-options" {
  provider = aws.other

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.vpc-B-accepter.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}