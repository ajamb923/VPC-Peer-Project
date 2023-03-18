// Instance - A
resource "aws_instance" "instanceA" {
    count = var.create_instance == true ? 1 : 0
    ami = var.ami[0]
    instance_type = var.instance-type
    subnet_id = aws_subnet.subnetA.id
    vpc_security_group_ids = [aws_security_group.vpcA-sg.id]
    key_name = var.keyname1
    tags = {
        Name = "INSTANCE-A"
    }
}


// Instance - B
resource "aws_instance" "instanceB" {
    count = var.create_instance == true ? 1 : 0
    ami = var.ami[1]
    instance_type = var.instance-type
    subnet_id = aws_subnet.subnetB.id
    vpc_security_group_ids = [aws_security_group.vpcB-sg.id]
    key_name = var.keyname2
    tags = {
        Name = "INSTANCE-B"
    }

    provider = aws.other
}
