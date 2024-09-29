# Create Elastic IP
resource "aws_eip" "dev_eip" {
  # Meta Argument
  depends_on = [ aws_internet_gateway.dev_igw ]
  
  tags = {
    Name = "DEV-EIP"
  }
}