# Create Security Group - SSH Traffic
resource "aws_security_group" "web-ssh" {
  name = "web-ssh"
  description = "Allow Web and SSH Inbound Traffic"
  vpc_id = aws_vpc.dev_vpc.id

ingress {
    description =   "Allow Port 22"
    from_port   =   22
    to_port     =   22
    protocol    =   "tcp"
    cidr_blocks  =   [aws_vpc.dev_vpc.cidr_block, "34.231.229.219/32"]
}

ingress {
    description =   "Allow Port 80"
    from_port   =   80
    to_port     =   80
    protocol    =   "tcp"
    cidr_blocks  =   ["0.0.0.0/0"]
}

egress  {
    description =   "Allow all ips and ports for outbound"
    from_port   =   0
    to_port     =   0
    protocol    =   "-1"
    cidr_blocks  =   ["0.0.0.0/0"]
}

tags = {
    Name    =   "web-ssh"
    }
}

# Create Security Group for Database Traffic

resource "aws_security_group" "sql-ssh" {
  name = "sql-ssh"
  description = "Allow Web Inbound Traffic"
  vpc_id = aws_vpc.dev_vpc.id

  ingress {
    description = "Allow Port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_vpc.dev_vpc.cidr_block]
  }

  ingress {
    description = "Allow Port 3306"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [aws_vpc.dev_vpc.cidr_block]
  }

  egress {
    description = "Allow all ports and ips for outbound"
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    =   "sql-ssh"
  }
}
