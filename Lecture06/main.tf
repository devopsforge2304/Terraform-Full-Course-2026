provider "aws" {
    region = "us-east-1"
  
}

resource "aws_vpc" "main_vpc" {

    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "rahul-vpc"
    }
  
}

#Implicit dependency 
resource "aws_subnet" "public_subnet" {

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "rahul-subnet"
    }
  
}

# Parallel execution (independent)
resource "aws_s3_bucket" "demo_bucket" {
    
    bucket = "rahul-practical06-bucket"
  
}

# Explicit dependency
resource "aws_instance" "web" {
  
  ami = "ami-02dfbd4ff395f2a1b"
  instance_type = "t3.micro"
  depends_on = [ aws_s3_bucket.demo_bucket ]

}