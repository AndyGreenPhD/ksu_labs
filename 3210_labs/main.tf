module "ubuntu_instances" {
  source = "./module"

  // Put SSH Key between the quotes
  public_key    = ""
  
  region        = "us-east-2"
  instance_type = "t2.micro"
  ami           = "ami-024e6efaf93d85776" 
}

output "addresses" {
  value = module.ubuntu_instances.public_ips
}
