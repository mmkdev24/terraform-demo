# Resource-4: Create Elastic IP
resource "aws_eip" "my-eip" {
  # Meta-Argument
  depends_on = [ aws_internet_gateway.my-igw ]
  tags = {
    Name = "Test-EIP"
  }
}