provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "example" {
    ami           = "ami-04902260ca3d33422"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
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

resource "aws_security_group" "instance"{
    name = "terraform-example-instance"

    ingress {
        from_port = var.server_port
        to_port = var.server_port 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type = number
    default = 80
}
