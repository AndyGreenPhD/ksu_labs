output "public_ips" {
  value = aws_instance.ubuntu_instance.*.public_ip
}