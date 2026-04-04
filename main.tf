import {
  to = digitalocean_droplet.node
  id = "562880345"
}

import {
  to = digitalocean_spaces_bucket.bucket
  id = "fra1,sokhanska-bucket"
}

import {
  to = digitalocean_vpc.vpc
  id = "0051ffac-b3b4-4acd-8b74-a5594333f5c9"
}

import {
  to = digitalocean_firewall.firewall
  id = "bb4c6801-e249-4192-bcb1-5ad60d947b78"
}

resource "digitalocean_droplet" "node" {
  name   = "task1"
  region = "fra1"
  size   = "s-2vcpu-4gb"
  image  = "ubuntu-24-04-x64"
}

resource "digitalocean_vpc" "vpc" {
  name     = "sokhanska-vpc"
  region   = "fra1"
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_firewall" "firewall" {
  name        = "sokhanska-firewall"
  droplet_ids = [digitalocean_droplet.node.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000-8003"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}

resource "digitalocean_spaces_bucket" "bucket" {
  name   = "sokhanska-bucket"
  region = "fra1"
}
