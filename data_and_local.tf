data "aws_ami" "Project01_AMI" {
    most_recent = true
    owners = [ "099720109477" ]
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" ]
    }
    
    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
  
}

resource "aws_key_pair" "Project01_Key_Pair" {
    key_name = "Project_01_key.pub"
    public_key = file("${path.module}/Project_01_key.pub")
  
}


locals {
  server_config = {
    ami = data.aws_ami.Project01_AMI.id
    type = "t2.micro"
    subnet = aws_subnet.Project01_Public_Subnet.id
    key_name = aws_key_pair.Project01_Key_Pair.key_name
    security_tags = [ aws_security_group.Project01_SG.id ]

    tags = {
        Name = "Project01_Server"
    }
  }
}