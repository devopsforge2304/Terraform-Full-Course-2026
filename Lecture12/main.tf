provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "web_rerver" {
    ami = "ami-0ec10929233384c7f"
    instance_type = "t3.micro"
    key_name = "terraform-examples"
    vpc_security_group_ids = [ "sg-0d0aefca338672102" ]

    provisioner "file" {

        source = "app.py"
        destination = "/home/ubuntu/app.py"
      
    }

    provisioner "remote-exec" {

        inline = [ 
            "sudo apt update -y",
            "sudo apt install python3-pip python3-venv -y",
            "python3 -m venv /home/ubuntu/venv",
            "/home/ubuntu/venv/bin/pip install flask"

         ]
      
    }

    provisioner "local-exec" {

        command = "echo EC2 public id is ${self.public_ip}"
      
    }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("terraform-examples.pem")
      host = self.public_ip
    }
  

  tags = {
    Name = "Flask App Server"
  }
}

