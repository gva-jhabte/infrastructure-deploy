terraform {
  backend "gcs" {
    bucket  = "infrastructure-al-state"
    prefix  = "vpc/state"
  }
}