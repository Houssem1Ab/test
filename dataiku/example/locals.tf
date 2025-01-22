variable "project_id" {}
variable "location" {}
variable "region" {}
variable "zone" {}


locals {
  project_id            = var.project_id
  location              = var.location
  region                = var.region
  zone                  = var.zone
  dataiku_name          = "test_1"
  dataiku_setup_version = "12.6.3"
  node_type             = "design"
  format_map            = {}
  format_values = {
    "maison_trigram" = "grp"
    "env_trigram"    = "sta"
    "app_code"       = "atom"
  }
}