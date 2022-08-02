resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.region
  project = var.project
  
  networking_mode = "VPC_NATIVE"
  network = module.network.vpc_network.self_link
  subnetwork = module.network.private-subnet.self_link
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  
  
  #to keep in mind that you are not able to disable upgrade to master node
  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-ip-range"
    services_secondary_range_name = "services-ip-range"
  }

  network_policy {
    provider = "PROVIDER_UNSPECIFIED"
    enabled  = true
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "${google_compute_instance.vm-private.network_interface.0.network_ip}/32"
      display_name = "bastion_cidr"
    }
  }
  
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  #To grant permissions on the pod level not on the node level
  workload_identity_config {
    identity_namespace = "gcp-project-356819.svc.id.goog"
  }
}

resource "google_container_node_pool" "general" {
  name       = "general"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  project    = var.project
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    labels = {
      role = "general"
    }
    machine_type = "e2-small"

    service_account = "gproject@gcp-project-356819.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}