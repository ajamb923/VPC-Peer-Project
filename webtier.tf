// Instance - A
resource "aws_instance" "instanceA" {
    count = var.create_instance == true ? 1 : 0
    ami = "ami-0b5eea76982371e91"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnetA.id
    vpc_security_group_ids = [aws_security_group.vpcA-sg.id]
    key_name = "NOVA_KP"
    tags = {
        Name = "INSTANCE-A"
    }
}


// Instance - B
resource "aws_instance" "instanceB" {
    count = var.create_instance == true ? 1 : 0
    ami = "ami-05bfbece1ed5beb54"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnetB.id
    vpc_security_group_ids = [aws_security_group.vpcB-sg.id]
    key_name = "Ohio_KP"
    tags = {
        Name = "INSTANCE-B"
    }

    provider = aws.other
}
