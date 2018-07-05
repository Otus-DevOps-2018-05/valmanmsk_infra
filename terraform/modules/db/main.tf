resource "google_compute_instance" "db" {
  name         = "${var.reddit_db}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {
   }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
 connection {
    type        = "ssh"
    user        = "appuser"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source     = "${path.module}/files/mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/mongo_config.sh"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "${var.allow_mongo}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  # правило применимо к инстансам с тегом ...
  target_tags = ["reddit-db"]

  # порт будет доступен только для инстансов с тегом ...
  source_tags = ["reddit-app"]
}

