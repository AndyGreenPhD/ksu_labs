module "ubuntu_instances" {
  source = "./module"

  // Put SSH Key between the quotes
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkIU34jM5nog3mFA8Lf0tQDuA5tYY8WRsvaiEv2Px/phbHBzRrfYhKm342K1zRUl233XKk+PZp2ATWPfmXMh+5rPzGBxdRpPYeb+At5vTdRYmO6Xb7RalFJ3p8tJjbsfPqMcDBy5BNlQLI6qaoqnN/+kM4nVrElLT1dvedrbyixATgppDb/+nnvT6w/Da7DlSnWEiqRuKPG/EsrMqjWhaxx+YGlriuLNdbZ4tuhQ+M+1xgWy9t0zPC4qbOVONK9ZO0DbmsnUvc48q97wLBgMakKcw1ryJdPgh5WoE5DGepD8Ampu62+rVqdWd2zKxEoSDA5z8SnNa7SR6IpORLdoXt46DN2YNnrjL1xAMD/VZ/+4HEKDh+PvDN3bluRLGBOCMUItlZS6VNcNLhkLd/4wYF5fsNd1X+U0Jq3fgT9XjJ6KaIpx6K0oPJ4JOclWL7l6qG60QOIwDlufVa5XiukT2AfU6iZ/PwY9zofqe9BvmvSZUCjMcPrXCw1OI9cGEk4JU="
  
  region        = "us-east-2"
  instance_type = "t2.micro"
  ami           = "ami-024e6efaf93d85776" 
}

output "addresses" {
  value = module.ubuntu_instances.public_ips
}
