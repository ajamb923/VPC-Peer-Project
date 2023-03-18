// LIST OF ALL VARIABLES

variable "create_instance" {
    type = bool
    default = true
}

variable "vpc_cidr_block" {}

variable "subnet_cidr_block" {}

variable "ami" {}

variable "instance-type" {}

variable "keyname1" {}

variable "keyname2" {}

variable "peer-region" {}