variable "credentials" {
  type = string
}

variable "project" {
  type = string
}

provider "google" {
  credentials = "${file(var.credentials)}"
  project = var.project
  zone = "europe-west2-a"
}

resource "google_compute_network" "vm-network" {
  name = "vm-network"
}

resource "google_compute_firewall" "vm-firewall" {
  name = "vm-firewall"
  network = "${google_compute_network.vm-network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }
}

resource "google_compute_address" "vm-external-ip" {
  name = "vm-external-ip"
}

output "vm-external-ip" {
  value = "${google_compute_address.vm-external-ip.address}"
}

resource "google_compute_instance" "vm" {
  name = "vm"
  machine_type = "f1-micro"
  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo 'Hello from VM!' | sudo tee /var/www/html/index.html"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "${google_compute_network.vm-network.name}"
    access_config {
      nat_ip = "${google_compute_address.vm-external-ip.address}"
    }
  }
}
