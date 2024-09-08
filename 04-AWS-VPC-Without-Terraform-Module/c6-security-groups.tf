# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-web-ssh" {
  name        = "vpc-web-ssh"
  description = "Allow Web & SSH inbound traffic"
  vpc_id = aws_vpc.my-vpc.id
  
  ingress {
    description = "Allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my-vpc.cidr_block]
  }
  ingress {
    description = "Allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vpc-web-ssh"
  }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-mysql-ssh" {
  name        = "vpc-mysql-ssh"
  description = "Allow Web inbound traffic"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    description = "Allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my-vpc.cidr_block]
  }
  ingress {
    description = "Allow port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my-vpc.cidr_block]
  }  

  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vpc-mysql-ssh"
  }
}