# EC2 Instance list & Map variables. In Map, it should be key & vaule pair.  
# Count is a meta argument which is not the orginal resource parameter or argument of AWS.
# Count is something like additional argument present in terraform out of which count, foreach etc
# all these things we can use to change the behavior of the resource.   
resource "aws_instance" "myec2vm" {
    ami = data.aws_ami.amzlinux.id
    #instance_type = var.instance_type
    instance_type = var.instance_type_list[0]  ## Instance List
    #instance_type = var.instance_type_map["dev"]
    #user_data = file("${path.module}/app1-install.sh")
    key_name = var.instnace_keypair
    vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
    count = 2
    tags = {
        "Name" = "EC2-Test-${count.index}" 
    }  
}