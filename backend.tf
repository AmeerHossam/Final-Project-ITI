terraform {
  backend "gcs" {
    bucket  = "gcp-tf-state-file"
    prefix  = "terraform/state"
  }
}