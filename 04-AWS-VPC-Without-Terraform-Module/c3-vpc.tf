# Resources Block
# Resource-1: Create VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Test-VPC"
  }
}

# Resource-2: Create Public Subnet
resource "aws_subnet" "test-public-subnet-01" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Test-Public-Subnet"
  }
}

# Resource-3: Create Private Subnet
resource "aws_subnet" "test-private-subnet-01" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Test-Private-Subnet"
  }
}

# Resource-4: Create Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "Test-IGW"
  }
}

# Create Public Route Table in order to connect our public subnet to the Internet Gateway
resource "aws_route_table" "my-public-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "Test-Public-RT"
  }  
}

#Create Route in Route Table for Internet Access and attach IGW
resource "aws_route" "my-public-route" {
  route_table_id = aws_route_table.my-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my-igw.id
}

#Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "pub-rt-associate" {
  route_table_id = aws_route_table.my-public-route-table.id
  subnet_id = aws_subnet.test-public-subnet-01.id
}

# Resource-5:  Create NAT Gateway
resource "aws_nat_gateway" "my-natgw" {
  allocation_id = aws_eip.my-eip.id
  subnet_id = aws_subnet.test-public-subnet-01.id
  tags = {
    Name = "Test-NAT-GW"
  }
}

# Create a Private Route Table in order to connect our private subnet to the NAT Gateway
resource "aws_route_table" "my-private-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "Test-Private-RT"
  }  
}


# Create Route in Private Route Table and attach NAT Gateway
resource "aws_route" "my-private-route" {
  route_table_id = aws_route_table.my-private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.my-natgw.id
}

# Associate the Private Route Table with Private Subnet
resource "aws_route_table_association" "pvt-rt-associate" {
  route_table_id = aws_route_table.my-private-route-table.id
  subnet_id = aws_subnet.test-private-subnet-01.id
}
