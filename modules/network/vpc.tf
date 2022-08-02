resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
    routing_mode = "GLOBAL"
    auto_create_subnetworks = false

}