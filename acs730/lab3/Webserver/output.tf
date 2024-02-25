# Output the Public IP address of Instance
output "public_ip" {
  value = aws_instance.lab3_ec2.public_ip
}