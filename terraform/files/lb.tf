resource "google_compute_target_pool" "reddit-srv" {
  name = "reddit-srv"

  instances     = ["${google_compute_instance.app.*.self_link}"]
  health_checks = ["${google_compute_http_health_check.default.name}"]
}

resource "google_compute_http_health_check" "default" {
  name               = "default"
  port               = "9292"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_forwarding_rule" "lb" {
  name       = "reddit-forwarding-rule"
  target     = "${google_compute_target_pool.reddit-srv.self_link}"
  port_range = "9292"
}
