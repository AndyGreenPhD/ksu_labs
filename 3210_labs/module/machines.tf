data "cloudinit_config" "cloud-config" {
  part {
    content_type = "text/cloud-config"
    content = file("${path.module}/cloud-config.yml")
  }  
}

resource "aws_key_pair" "lab" {
  key_name   = "lab-key"
  public_key = var.public_key
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
  ami           = var.ami
  instance_type = var.instance_type
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