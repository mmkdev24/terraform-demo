# About for_each Meta Arguments
# https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

# About aws_availability_zones
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones

data "aws_availability_zones" "my_azs" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Create EC2 Instance in all Availabilty Zones of a VPC
resource "aws_instance" "myec2vm" {
    ami = data.aws_ami.amzlinux.id
    instance_type = var.instance_type
    #user_data = file("${path.module}/app1-install.sh")
    key_name = var.instnace_keypair
    vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
    # The for_each meta-argument accepts a map or a set of strings. It doesn't accept the list.
    # names is the attribute reference to get list of the Availability Zone names available to the account
    # toset function converts it's arguments to a set value
    for_each = toset(data.aws_availability_zones.my_azs.names)
    availability_zone = each.key
    # You can also use each.vaule because for list items each.key == each.value
    tags = {
        "Name" = "EC2-Test-${each.key}" 
    }  
}
