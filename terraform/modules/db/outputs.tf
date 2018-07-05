output "db_address" {
  value = "${google_compute_instance.db.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "db_internal_ip" {
  value = "${google_compute_instance.db.network_interface.0.address}"
}

