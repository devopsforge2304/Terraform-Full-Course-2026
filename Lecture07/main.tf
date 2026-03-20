provider "aws" {

    region = "us-east-1"
  
}

terraform {
  backend "s3" {
    bucket = "rahul-terraform-practical06-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
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

