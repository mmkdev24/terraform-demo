# About for_each Meta Arguments
# https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

# About aws_availability_zones
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones


# Create EC2 Instance for MariaDB
resource "aws_instance" "myec2-db" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  #user_data = file("${path.module}/app1-install.sh")
  key_name = var.instnace_keypair
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo dnf install mariadb105-server -y
    sudo systemctl enable mariadb
    sudo systemctl start mariadb
    EOF  
  subnet_id = aws_subnet.test-private-subnet-01.id
  vpc_security_group_ids = [aws_security_group.vpc-mysql-ssh.id]
  tags = {
      "Name" = "EC2-Test-DB" 
  }  
}

# Create EC2 Instance for Web
resource "aws_instance" "myec2-web" {
  ami = data.aws_ami.amzlinux.id
  instance_type = var.instance_type
  #user_data = file("${path.module}/app1-install.sh")
  key_name = var.instnace_keypair
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to DevOps Learning ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    EOF  
  subnet_id = aws_subnet.test-public-subnet-01.id
  vpc_security_group_ids = [aws_security_group.vpc-web-ssh.id]
  tags = {
      "Name" = "EC2-Test-WEB" 
  }  
}
