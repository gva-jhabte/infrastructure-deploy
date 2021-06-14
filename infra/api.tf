resource "google_project_service" "services" {
  for_each = toset([
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com"
  ])

  service = each.key

  project            = google_project.project.project_id
  disable_on_destroy = false
}