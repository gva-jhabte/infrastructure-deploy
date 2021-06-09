# making the vpc and other relevant areas

resource "google_compute_network" "peering_network" {
  name = "peering-network"
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.peering_network.id
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.peering_network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_vpc_access_connector" "connector" {
  name          = "vpc-con"
  ip_cidr_range = "10.3.0.0/28"
  network       = google_compute_network.peering_network.name
  region        = var.region
  max_throughput = 1000
}

resource "google_service_networking_connection" "foobar" {
  network                 = google_compute_network.peering_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

# making the cloud task queue

resource "google_cloud_tasks_queue" "default" {
  name = "my-queue"
  location = "europe-west1"
}

# making the sql instance

resource "google_sql_database_instance" "master" {
  name             = "state-database"
  database_version = "POSTGRES_12"
  region           = var.region

  depends_on = [google_service_networking_connection.foobar]

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-custom-4-26624"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.peering_network.id
      require_ssl     = true
    }
  }
}
