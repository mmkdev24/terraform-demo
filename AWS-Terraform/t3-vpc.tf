# Create VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block = "192.168.0.0/24"

  tags = {
    Name = "dev_vpc"
  }
}

# Create Public Subnet
resource "aws_subnet" "dev_pub_subnet" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = "192.168.0.0/26"
  map_public_ip_on_launch = true

  availability_zone = "us-east-1a"

  tags = {
    Name    =   "dev_pub_subnet"
  }
}

# Create Private Subnet-1
resource "aws_subnet" "dev_prv_subnet_1" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = "192.168.0.64/26"
  availability_zone = "us-east-1b"

  tags = {
    Name    =   "dev_prv_subnet_1"
  }
}

#Create Private Subnet-2
resource "aws_subnet" "dev_prv_subnet_2" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = "192.168.0.128/26"
  availability_zone = "us-east-1c"

  tags = {
    Name    =   "dev_prv_subnet_2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name    =   "dev_igw"
  }
}

# Create NAT Gateway for Private Subnets

resource "aws_nat_gateway" "dev_natgw" {
  allocation_id = aws_eip.dev_eip.id
  subnet_id = aws_subnet.dev_pub_subnet.id

  tags = {
    Name    =   "dev_natgw"
  }
}

# Create Public Route Table
resource "aws_route_table" "dev_pub_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  tags  = {
    Name  = "DEV-PUB-RT"
  }
}

# Create Route in Route Table for internet access

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.dev_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.dev_igw.id
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_rt_association" {
  subnet_id = aws_subnet.dev_pub_subnet.id
  route_table_id = aws_route_table.dev_pub_rt.id
}

# Create Private Route Table for NAT Gateway 
resource "aws_route_table" "dev_prv_rt_1" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name  = "DEV-PVT-RT-1"
  }
}

# Create route in private route for table and associate NAT Gateway 
resource "aws_route" "private_route1" {
  route_table_id = aws_route_table.dev_prv_rt_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.dev_natgw.id
}  

# Associate Private Subnet 1 with Private Route Table 1
resource "aws_route_table_association" "private_association_1" {
  subnet_id = aws_subnet.dev_prv_subnet_1.id
  route_table_id = aws_route_table.dev_prv_rt_1.id

}
    

# Create Private Route Table for Private Subnet 2
resource "aws_route_table" "dev_prv_rt_2" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name  = "DEV-PVT-RT-2"
  }
}


# Associate Private Subnet 2 with Private Route Table 2
resource "aws_route_table_association" "private_association_2" {
  subnet_id = aws_subnet.dev_prv_subnet_2.id
  route_table_id = aws_route_table.dev_prv_rt_2.id
}
