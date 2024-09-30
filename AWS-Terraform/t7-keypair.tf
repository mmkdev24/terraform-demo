# Generate the private key locally
provider "tls" {}
resource "tls_private_key" "pvt_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "dev_vpc_key" {
  key_name = "dev_vpc_key"
  public_key = tls_private_key.pvt_key.public_key_openssh
}

provider "local" {}
  resource "local_file" "key" {
    content = tls_private_key.pvt_key.private_key_pem
    filename = "dev-vpc-key.pem"
}
