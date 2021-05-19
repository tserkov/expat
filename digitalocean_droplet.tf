resource "digitalocean_droplet" "exit_node" {
	count = var.node_count

	image      = var.do_image
	name       = "tailscale-exit-node-${var.do_region}-${count.index}"
	region     = var.do_region
	size       = var.do_size
	ipv6       = true
	ssh_keys   = [var.do_public_key_id]
	tags       = ["terraform", "tailscale", "exit-node"]

	connection {
		type        = "ssh"
		user        = "root"
		host        = "${self.ipv4_address}"
		private_key = file("${var.do_private_key_path}")
	}

	provisioner "file" {
		source      = "provision.sh"
		destination = "/tmp/provision.sh"
	}

	provisioner "remote-exec" {
		inline = [
			"chmod +x /tmp/provision.sh",
			"/tmp/provision.sh ${var.ts_authkey}",
		]
	}
}
