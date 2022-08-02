resource "google_compute_firewall" "vpc_firewall" {
  name    = "fw-allow-ssh"
  network = google_compute_network.vpc_network.name
  # direction = "INGRESS"
  direction = "INGRESS"
  project = "gcp-project-356819"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [ "0.0.0.0/0" ]
  target_tags = [ "bastion" ]
}

resource "google_compute_firewall" "allow-http" {
  name = "fw-allow-http"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"]
}