#terrafrom required provider block
terraform {
required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami                     = "ami-02dfbd4ff395f2a1b"
  instance_type           = "t3.micro"
  key_name                = "terraform-examples" 
  subnet_id               = "subnet-07b8a1ecbe3cd3b56" 

  tags = {
    Name = "Terraform-EC2-Example"
  }
}