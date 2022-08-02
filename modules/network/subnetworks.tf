resource "google_compute_subnetwork" "bastion-subnetwork" {
  name = "bastion-subnet"
  ip_cidr_range = var.bastion-cidr
  region = var.region
  network = google_compute_network.vpc_network.name
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private-subnetwork" {
    name = "private-subnet"
    ip_cidr_range = var.private-cidr
    region = var.region
    network = google_compute_network.vpc_network.name
    private_ip_google_access = true


#k8s nodes use IPs from the main IP ranges
#k8s pods use IPs from the secondary IP ranges

secondary_ip_range {
    range_name = "pod-ip-range"
    ip_cidr_range = "10.48.0.0/14"
}

#It will to assign IP addresses for the Cluster IPs in the K8S
secondary_ip_range {
    range_name = "services-ip-range"
    ip_cidr_range = "10.52.0.0/20"
}
}