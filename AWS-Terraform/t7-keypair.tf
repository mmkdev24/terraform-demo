# Generate the private key locally
provider "tls" {}
resource "tls_private_key" "tf_key" {
  algorithm = "RSA"
  rsa_bits = 4098
}

resource "aws_key_pair" "dev_vpc_key" {
  key_name = "devvpc_key"
  public_key = tls_private_key.tf_key.public_key_openssh
}

provider "local" {}
  resource "localfile" "pem_file" {
    content = tls_private_key.tf_key.private_key_pem
    filename = "dev-vpc-key.pem"
    file_permissions = "0400"
  }
