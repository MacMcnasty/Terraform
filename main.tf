provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example" {
    ami           = "ami-04902260ca3d33422"
    instance_type = "t3.micro"

    tags = {
        Name = "Terraform-Example"
    }
}
