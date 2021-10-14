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