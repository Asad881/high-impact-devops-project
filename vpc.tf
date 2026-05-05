resource "aws_vpc" "Project01_VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "Project01_VPC"
    }
}

resource "aws_internet_gateway" "Project01_Gateway" {
    vpc_id = aws_vpc.Project01_VPC.id
    tags = {
        Name = "Project01_Gateway"
    }
  
}

resource "aws_subnet" "Project01_Public_Subnet"{
    vpc_id = aws_vpc.Project01_VPC.id
    map_public_ip_on_launch = true
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "Project01_Public_Subnet"
    }
}

resource "aws_route_table" "Project01_Route_Table" {
    vpc_id = aws_vpc.Project01_VPC.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Project01_Gateway.id
    }

    tags = {
        Name = "Project01_Route_Table"
    }
}

resource "aws_route_table_association" "Project01_Route_Table_Association" {
   subnet_id = aws_subnet.Project01_Public_Subnet.id
   route_table_id = aws_route_table.Project01_Route_Table.id
  
}