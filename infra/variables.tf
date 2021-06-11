variable "project" {
  description = "The project ID to create the resources in."
  type        = string
  default       = "dcsgva-lab-sandbox-jonathan"
}

variable "region" {
  description = "The region to create the resources in."
  type        = string
  default       = "europe-west4"
}

variable "instance_name" {
  description = "The name of the gcloud instance"
  type        = string
  default     = "state-database"
}