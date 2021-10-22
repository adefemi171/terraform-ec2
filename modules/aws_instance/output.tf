output "KEY_NAME" {
    value = aws_key_pair.default.key_name
}

output "INSTANCE_ARN" {
    value = aws_instance.default.arn
}

output "INSTANCE_PUBLIC_IP" {
    value = aws_instance.default.public_ip
}

output "INSTANCE_PUBLIC_DNS" {
    value = aws_instance.default.public_dns
}