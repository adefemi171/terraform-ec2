resource "aws_key_pair" "default" {
	key_name   = vars.key_name #"keypairSample"
	public_key = vars.public_key #"${file("keypairSample.pub")}"
}

resource "aws_instance" "default" {
	ami           = var.ami
	instance_type = var.instance_type
    # the VPC subnet
	subnet_id = var.subnet_id # "${aws_subnet.main-1.id}"

	# the security group
	vpc_security_group_ids = var.vpc_security_group_ids #["${aws_security_group.allow-ssh.id}"]

	# the public SSH key
	key_name = var.key_pair_name #"${aws_key_pair.keypairSample.key_name}"

	monitoring = var.monitoring

	# user data
    user_data =  var.user_data#$"${file("./user_data/nginx.sh")}"

	root_block_device = var.root_block_device

	tags = var.tags

    # tags = {
    #     Name = "Nginx-Instance"
    # }
}