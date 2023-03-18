// Provider for 1st Region 
provider "aws" {
    region = "us-east-1"
}

// Provider for 2nd Region
provider "aws" {
    region = "us-east-2"
    alias = "other"
}

