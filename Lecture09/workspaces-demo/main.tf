provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "web" {

    ami = "ami-02dfbd4ff395f2a1b"

    instance_type = lookup(
        var.instance_type,
        terraform.workspace
    )

    tags = {
      Name = "workspace-demo"
    }
  
}