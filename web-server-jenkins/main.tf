# Provision a web server instance using the latest Ubuntu 16.04 on a
# t2.micro node with an AWS Tag naming it "web-server"
provider "aws" {
     region = "ap-southeast-1"
     profile = "sopheamak"
}

# Create web server
resource "aws_instance" "web_server" {
    ami = "${data.aws_ami.ubuntu.id}"
    vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
    instance_type = "t2.micro"
    key_name      = "web_server"
    tags = {
        Name = "web-server"
    }

  connection {
    user         = "ubuntu"
    host         = "${self.public_ip}"
    private_key  = "${file("~/.ssh/id_rsa")}"
  }


  provisioner "file" {
    source = "package-install.sh"
    destination = "/home/ubuntu/package-install.sh"
  }

  provisioner "remote-exec" {
     inline = [
      "sudo chmod +x /home/ubuntu/package-install.sh",
      "sudo sh /home/ubuntu/package-install.sh",
    ]
  }

  provisioner "file" {
    source = "index.html"
    destination = "/var/www/html/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 644 /var/www/html/index.html"
    ]
  }

  # Save the public IP for testing
  provisioner "local-exec" {
    command = "echo ${aws_instance.web_server.public_ip} > public-ip.txt"
  }
}
