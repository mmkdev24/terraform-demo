# Create DB1 Instance
resource "aws_instance" "ec2-db_1" {
  ami = data.aws_ami.amazonlinux.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo dnf install mariadb105-server -y
    sudo systemctl enable mariadb
    sudo systemctl start mariadb
    EOF  
  subnet_id = aws_subnet.dev_prv_subnet_1.id
  vpc_security_group_ids = [aws_security_group.sql-ssh.id]
  tags = {
      "Name" = "EC2-Test-DB_1" 
  }  
}

# Create EC2 Instance for Web
resource "aws_instance" "ec2-web" {
  ami = data.aws_ami.amazonlinux.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to DevOps Learning ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
    EOF  
  subnet_id = aws_subnet.dev_pub_subnet.id
  vpc_security_group_ids = [aws_security_group.web-ssh.id]
  tags = {
      "Name" = "EC2-Test-WEB" 
  }  
}

# Create DB2 Instance without Internet connection

resource "aws_instance" "ec2-db_2" {
  ami = data.aws_ami.amazonlinux.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  subnet_id = aws_subnet.dev_prv_subnet_2.id
  vpc_security_group_ids = [aws_security_group.sql-ssh.id]
  tags = {
      "Name" = "EC2-Test-DB_2" 
  }  
}
