provider "google" {
  version = "~> 3.1.0"
  region  = var.region
  project = var.project_id
}

provider "google-beta" {
  version = "~> 3.1.0"
  region  = var.region
  project = var.project_id
}