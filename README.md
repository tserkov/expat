# Expat
A [Terraform](https://www.terraform.io/) module that creates a [Tailscale](https://tailscale.com/) exit node on [DigitalOcean](https://digitalocean.com/) infrastructure.

## Requirements
- [Terraform](https://www.terraform.io/) v0.15.3+
- A [Tailscale](https://tailscale.com/) account and [pre-authorization key](https://login.tailscale.com/admin/settings/authkeys)
- A [DigitalOcean](https://digitalocean.com/) account and [personal access token](https://cloud.digitalocean.com/account/api/tokens) (read & write)

## Quick Start
1. `git clone https://github.com/tserkov/expat.git`
2. `cd expat`
3. `terraform init`
4. `terraform apply`
5. Follow [Tailscale's Exit Nodes Steps 2 - 4](https://tailscale.com/kb/1103/exit-nodes/#step-2-allow-the-exit-node-from-the-admin-console)

# Variables
| Name | Description | Default |
| --- | --- | --- |
| `do_image` | DigitalOcean droplet image | `"debian-10-x64"` |
| `do_pat` | DigitalOcean Personal Access Token | _none_ |
| `do_private_key_path` | Path to private key for SSH | _none_ |
| `do_public_key_id` | DigitalOcean public key ID for SSH | _none_ |
| `do_region` | DigitalOcean droplet region | `"nyc3"` |
| `do_size` | DigitalOcean droplet size | `"s-1vcpu-1gb"` |
| `node_count` | The number of exit nodes to create | `1` |
| `ts_authkey` | Tailscale pre-authorization key | _none_ |

# Rationale
As an American traveling abroad, I wanted to access U.S. streaming service content. Tailscale's exit nodes allow for a "classic" self-hosted VPN, rather than trusting a 3rd party. I already use DigitalOcean and Terraform for other infrastructure, so this setup was a natural fit.

Technically, you could create your own server on any host and use the `provision.sh` script to install and run Tailscale, if you didn't want to use Terraform + DigitalOcean.
