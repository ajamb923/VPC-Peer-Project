// VPC - B
resource "aws_vpc" "vpcB" {
    cidr_block = var.vpc_cidr_block[1]
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "VPC-B"
    }

    provider = aws.other
}


// SUBNET - B
resource "aws_subnet" "subnetB" {
    vpc_id  = aws_vpc.vpcB.id 
    map_public_ip_on_launch = true
    cidr_block  = var.subnet_cidr_block[1]
    tags = {
        Name = "SUBNET-B"
    }

    provider = aws.other
}


// IGW - B
resource "aws_internet_gateway" "igwB" {
    vpc_id = aws_vpc.vpcB.id 
    tags = {
        Name = "IGW-B"
    }

    provider = aws.other
}


// ROUTE_TABLE - B
resource "aws_route_table" "rtB" {
    vpc_id = aws_vpc.vpcB.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igwB.id 
    }

    route {
        cidr_block = var.vpc_cidr_block[0]
        gateway_id = aws_vpc_peering_connection.vpcA-B.id
    }

    tags = {
      Name = "ROUTE-TABLE-B"
    }

    depends_on = [aws_vpc.vpcA, aws_vpc_peering_connection.vpcA-B]
    provider = aws.other
}


// ASSOCIATE SUBNET TO ROUTE TABLE - B
resource "aws_route_table_association" "assocB" {
    subnet_id = aws_subnet.subnetB.id 
    route_table_id = aws_route_table.rtB.id 

    provider = aws.other
}