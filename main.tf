terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  # We use a dummy project ID so it is physically impossible to deploy to your real lab
  project = "dummy-project-1234335" 
  region  = "europe-west3"
}

# This is the blueprint for the GCP Firewall Rule we built
resource "google_compute_firewall" "allow_lb" {
  name    = "allow-lb-health-checks-iac"
  network = "provider-b-vpc"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # Restrict to Google's Load Balancer IPs
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  
  description = "Allows LB health checks and internet traffic to the webservice"
}
