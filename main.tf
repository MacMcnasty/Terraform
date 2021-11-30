provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example" {
    ami           = "ami-04902260ca3d33422"
    instance_type = "t3.micro"
    user_data = <<EOF
                #!/bin/bash
                yum install httpd -y
                echo "<html><body><h1>Hello Everyone</h1></body></html>" >/var/www/html/index.html
                systemctl start httpd
                systemctl enable httpd
                EOF

    tags = {
        Name = "Terraform-Example"
    }
}
