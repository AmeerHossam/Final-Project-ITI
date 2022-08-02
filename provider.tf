provider "google" {
  project     = "gcp-project-356819"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "${file("./my-key.json")}"
}