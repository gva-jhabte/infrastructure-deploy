terraform {
  backend "gcs" {
    prefix  = "vpc/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.43.0"
    }
  }
}