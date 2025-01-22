data "google_compute_network" "shared" {
  project = var.shared_vpc_project_id
  name    = var.shared_vpc_name
}

data "google_compute_subnetwork" "shared" {
  project = var.shared_vpc_project_id
  region  = var.shared_vpc_subnet_region
  name    = var.shared_vpc_subnet_name
}

data "google_secret_manager_secret_version" "ssl_certificate" {
  secret  = var.ssl_certificate_secret_id
  project = var.project_id
}

data "google_secret_manager_secret_version" "ssl_private_key" {
  secret  = var.ssl_private_key_secret_id
  project = var.project_id
}

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

# Data source to retrieve the source data disk type (only available for zonal disks in version 4.75.1 of google provider)
data "google_compute_disk" "fusion-source-disk" {
  count   = startswith(local.source_data_disk, "zone") ? 1 : 0
  project = var.project_id
  name    = element(split("/", local.source_data_disk), length(split("/", local.source_data_disk)) - 1)
  zone    = element(split("/", local.source_data_disk), 1)
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = local.compute_data_disk_region
}
