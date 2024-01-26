locals {
  AWS_ACCESS_KEY_ID     = "ACCESS_KEY_HERE"
  AWS_SECRET_KEY        = "ACCESS_SECRET_KEY"
  SSH_KEY               = "SSH_KEY_HERE"
}

## EDIT NOTHING BELOW THIS LINE

provider "aws" {
  region     = "us-east-2"
  access_key = local.AWS_ACCESS_KEY_ID
  secret_key = local.AWS_SECRET_KEY
}

data "cloudinit_config" "cloud-config" {
  part {
    content_type = "text/cloud-config"
    content = file("${path.module}/cloud-config.yml")
  }  
}

resource "aws_key_pair" "lab" {
  key_name   = "lab-key"
  public_key = local.SSH_KEY
}

resource "aws_security_group" "allow_http_https_ssh" {
  name_prefix = "allow_http_https_ssh"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ubuntu_instance" {
  count         = 2
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.lab.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_https_ssh.id]

  user_data = data.cloudinit_config.cloud-config.rendered

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    timeout     = "2m"
    host        = self.public_ip
  }

  tags = {
    Name = "System ${count.index + 1}"
  }
}
output "addresses" {
  value = aws_instance.ubuntu_instance.*.public_ip
}
