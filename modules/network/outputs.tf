output "bastion-subnet" {
  value = google_compute_subnetwork.bastion-subnetwork
}

output "private-subnet" {
  value = google_compute_subnetwork.private-subnetwork
}

output "vpc_network" {
  value = google_compute_network.vpc_network
}

output "nat_ip_address" {
  value = google_compute_address.nat-ip.address
}