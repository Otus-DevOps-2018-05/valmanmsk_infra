output "app.0_external_ip" {
  value = "${google_compute_instance.app.0.network_interface.0.access_config.0.assigned_nat_ip}"
}
output "app.1_external_ip" {
  value = "${google_compute_instance.app.1.network_interface.0.access_config.0.assigned_nat_ip}"
}
output "lb_external_ip" {
  value = "${google_compute_forwarding_rule.lb.ip_address}"
}

