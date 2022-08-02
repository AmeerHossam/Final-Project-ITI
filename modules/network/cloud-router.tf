resource "google_compute_router" "cloud-router" {
  name    = "my-router"
  network = google_compute_network.vpc_network.id
  region =  var.region

}