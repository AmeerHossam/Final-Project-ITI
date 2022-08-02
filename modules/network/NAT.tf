# create a public ip for nat service
resource "google_compute_address" "nat-ip" {
  name = "nap-ip"
  project = var.project
  region  = var.region
}


resource "google_compute_router_nat" "nat-gateway" {
  name                               = "my-nat-gateway"
  router                             = google_compute_router.cloud-router.name
  region                             = google_compute_router.cloud-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.bastion-subnetwork.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  subnetwork {
    name                    = google_compute_subnetwork.private-subnetwork.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}