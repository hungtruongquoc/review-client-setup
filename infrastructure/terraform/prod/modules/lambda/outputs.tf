output "lambda-tenant-service-security-group" {
    value = "${aws_security_group.default.*.id}"
}
