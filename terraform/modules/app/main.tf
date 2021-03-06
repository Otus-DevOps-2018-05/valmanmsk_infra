data "template_file" "pumaserv" {
  template = "${file("${path.module}/files/puma.service.tpl")}"

  vars {
    db_address = "${var.db_address}"
  }
}
resource "google_compute_instance" "app" {
  name         = "${var.reddit_app}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

/*  provisioner "file" {
    content      = "${data.template_file.pumaserv.rendered}"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  } */
} 

resource "google_compute_address" "app_ip" {
  name = "${var.reddit_app_ip}"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "${var.allow_puma}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

