// VPC - A
resource "aws_vpc" "vpcA" {
    cidr_block = "1.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "VPC-A"
    }
}


// SUBNET - A
resource "aws_subnet" "subnetA" {
    vpc_id  = aws_vpc.vpcA.id 
    map_public_ip_on_launch = true
    cidr_block  = "1.0.1.0/24"
    tags = {
        Name = "SUBNET-A"
    }
}


// IGW - A
resource "aws_internet_gateway" "igwA" {
    vpc_id = aws_vpc.vpcA.id 
    tags = {
        Name = "IGW-A"
    }
}


// ROUTE_TABLE - A
resource "aws_route_table" "rtA" {
    vpc_id = aws_vpc.vpcA.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igwA.id 
    }

    route {
        cidr_block = "2.0.0.0/16"
        gateway_id = aws_vpc_peering_connection.vpcA-B.id
    }

    tags = {
      Name = "ROUTE-TABLE-A"
    }

    depends_on = [aws_vpc.vpcB, aws_vpc_peering_connection.vpcA-B]
}


// ASSOCIATE SUBNET TO ROUTE TABLE
resource "aws_route_table_association" "assocA" {
    subnet_id = aws_subnet.subnetA.id 
    route_table_id = aws_route_table.rtA.id 
}