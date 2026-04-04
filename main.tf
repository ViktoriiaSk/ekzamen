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
  name   = "sokhanska-bucket1"
  region = "fra1"
}
