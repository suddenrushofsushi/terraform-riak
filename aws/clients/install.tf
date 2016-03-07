resource "aws_instance" "server" {
    ami = "${lookup(var.ami, concat(var.region, "-", var.platform))}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${var.security_group_name}"]

    connection {
        user = "${lookup(var.user, var.platform)}"
        key_file = "${var.key_path}"
    }

    #Instance tags
    tags {
        Name = "${var.tagName}-${var.platform}"
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/bootstrap-${lookup(var.platform_base, var.platform)}.sh",
        ]
    }

}
