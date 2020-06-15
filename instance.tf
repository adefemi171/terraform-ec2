provider "aws" {
	region                  = "us-east-1"
}


resource "aws_key_pair" "keypairSample" {
	key_name   = "keypairSample"
	public_key = "${file("keypairSample.pub")}"
}

resource "aws_instance" "my-instance" {
	ami           = "ami-2757f631"
	instance_type = "t2.micro"
    # the VPC subnet
	subnet_id = "${aws_subnet.main-1.id}"

	# the security group
	vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

	# the public SSH key
	key_name = "${aws_key_pair.keypairSample.key_name}"

	# user data
    user_data =  "${file("./user_data/nginx.sh")}"

    tags = {
        Name = "Nginx-Instance"
    }
}


resource "aws_ebs_volume" "ebs-volume-1" {
	availability_zone = "us-east-1a"
	size              = 8
	type              = "gp2"
	tags = {
		Name = "volume data"
	}
}

resource "aws_vpc" "main" {
	cidr_block           = "10.0.0.0/16"
	instance_tenancy     = "default"
	enable_dns_support   = "true"
	enable_dns_hostnames = "true"
	enable_classiclink   = "false"
	tags = {
		Name = "main"
	}
}

resource "aws_security_group" "allow-ssh" {
	vpc_id      = "${aws_vpc.main.id}"
	name        = "allow-ssh"
	description = "security group that allows ssh and all egress traffic"
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	tags = {
		Name = "allow-ssh"
	}
}

# Subnets
resource "aws_subnet" "main-1" {
	vpc_id                  = "${aws_vpc.main.id}"
	cidr_block              = "10.0.1.0/24"
	map_public_ip_on_launch = "true"

	tags = {
		Name = "main-1"
	}
}

resource "aws_subnet" "main-2" {
	vpc_id                  = "${aws_vpc.main.id}"
	cidr_block              = "10.0.2.0/24"
	map_public_ip_on_launch = "true"

	tags = {
		Name = "main-2"
	}
}

resource "aws_subnet" "main-3" {
	vpc_id                  = "${aws_vpc.main.id}"
	cidr_block              = "10.0.3.0/24"
	map_public_ip_on_launch = "true"

	tags = {
		Name = "main-3"
	}
}

resource "aws_subnet" "main-private-1" {
	vpc_id                  = "${aws_vpc.main.id}"
	cidr_block              = "10.0.4.0/24"
	map_public_ip_on_launch = "false"

	tags = {
		Name = "main-private-1"
	}
}

resource "aws_subnet" "main-private-2" {
	vpc_id                  = "${aws_vpc.main.id}"
	cidr_block              = "10.0.5.0/24"
	map_public_ip_on_launch = "false"

	tags = {
		Name = "main-private-2"
	}
}

resource "aws_subnet" "main-private-3" {
	vpc_id                  = "${aws_vpc.main.id}"
	cidr_block              = "10.0.6.0/24"
	map_public_ip_on_launch = "false"

	tags = {
		Name = "main-private-3"
	}
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
	vpc_id = "${aws_vpc.main.id}"

	tags = {
		Name = "main"
	}
}

# route tables
resource "aws_route_table" "main-public" {
	vpc_id = "${aws_vpc.main.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.main-gw.id}"
	}

	tags = {
		Name = "main-public-1"
	}
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
	subnet_id      = "${aws_subnet.main-1.id}"
	route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-2-a" {
	subnet_id      = "${aws_subnet.main-2.id}"
	route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-3-a" {
	subnet_id      = "${aws_subnet.main-3.id}"
	route_table_id = "${aws_route_table.main-public.id}"
}
