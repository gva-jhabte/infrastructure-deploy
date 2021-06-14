provider "google" {
  version = "~> 3.1.0"
  region  = var.location
  project = var.project_id
}

provider "google-beta" {
  version = "~> 3.1.0"
  region  = var.location
  project = var.project_id
}