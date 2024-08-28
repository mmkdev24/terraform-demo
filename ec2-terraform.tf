provider "aws" {
  region = "us-east-1"
}

# Creating a new key pair while launching the instance_type

resource "aws_key_pair" "tf_demo" {
  key_name = "tf_demo"
  public_key = "${file("terraform-demo.pub")}"
}

resource "aws_instance" "amazon-instance" {
  ami           = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.tf_demo.key_name}"
}
