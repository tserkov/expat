#!/bin/sh

# This script updates a fresh Debian 10, then it installs Tailscale and starts it as an
# exit node.

# A Tailscale pre-authorization key (https://login.tailscale.com/admin/settings/authkeys)
# is required as the first and only argument.

set -e
export DEBIAN_FRONTEND=noninteractive

if [ $# -ne 1 ]; then
	echo "Only argument must be a Tailscale pre-authorization key!"
	exit 1
fi
AUTHKEY=$1

# If you enable DigitalOcean's monitoring, you will need to uncomment the following.
# This is because cloud-init will install ca-certificates, curl, gnupg2, and do-monitor, which
# locks the dpkg database. We need to wait for that to complete, so we wait 30 seconds before we use apt.
# echo PROVISIONER: Letting system warm up...
# sleep 30

echo PROVISIONER: Updating system...
apt update -y -qq && apt upgrade -y -qq

echo PROVISIONER: Installing dependencies...
apt-get install curl gnupg2 ca-certificates -yq

echo PROVISIONER: Enabling IP forwarding...
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

echo PROVISIONER: Adding Tailscale repository...
curl -fsSL https://pkgs.tailscale.com/stable/debian/buster.gpg | apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/debian/buster.list > /etc/apt/sources.list.d/tailscale.list
apt-get update -y -qq

echo PROVISIONER: Installing Tailscale...
apt-get install tailscale -y -qq

echo PROVISIONER: Starting Tailscale...
tailscale up --advertise-exit-node --authkey $AUTHKEY
