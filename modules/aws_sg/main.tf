resource "aws_security_group" "default" {
	vpc_id      = var.vpc_id #"${aws_vpc.main.id}"
	name        = var.name #"allow-ssh"
	description = var.description #"security group that allows ssh and all egress traffic"
	
	egress = var.egress
	# egress {
	# 	from_port   = 0
	# 	to_port     = 0
	# 	protocol    = "-1"
	# 	cidr_blocks = ["0.0.0.0/0"]
	# }

	ingress = var.ingress
	# ingress {
	# 	from_port   = 22
	# 	to_port     = 22
	# 	protocol    = "tcp"
	# 	cidr_blocks = ["0.0.0.0/0"]
	# }
    # ingress {
    #     from_port = 80
    #     to_port = 80
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

	tags = var.tags
	# tags = {
	# 	Name = "allow-ssh"
	# }
}
