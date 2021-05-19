variable "do_image" {
	description = "DigitalOcean droplet image"
	default = "debian-10-x64"
}

variable "do_pat" {
	description = "DigitalOcean Personal Access Token"
	sensitive = true
}

variable "do_private_key_path" {
	description = "Path to private key for SSH"
	sensitive = true
}

variable "do_public_key_id" {
	description = "DigitalOcean public key ID for SSH"
}

variable "do_region" {
	description = "DigitalOcean droplet region"
	default = "nyc3"
}

variable "do_size" {
	description = "DigitalOcean droplet size"
	default = "s-1vcpu-1gb"
}

variable "node_count" {
	description = "The number of exit nodes to create"
	default = 1
}

variable "ts_authkey" {
	description = "Tailscale pre-authorization key"
	sensitive = true
}
