module "enabled_services" {
  source = "../../utils/services"

  project_id = var.project_id
}
data "google_project" "current" {
  project_id = var.project_id
}

resource "google_project_iam_member" "start_stop_iam" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:service-${data.google_project.current.number}@compute-system.iam.gserviceaccount.com"
}

module "dataiku" {
  source = "../"

  format_map    = local.format_map
  format_values = local.format_values

  project_id = local.project_id
  location   = local.location
  region     = local.region
  zone       = local.zone

  name                        = local.dataiku_name
  shared_vpc_project_id       = google_compute_subnetwork.main.project
  shared_vpc_name             = google_compute_network.main.name
  shared_vpc_subnet_name      = google_compute_subnetwork.main.name
  shared_vpc_subnet_region    = google_compute_subnetwork.main.region
  ssl_certificate_secret_id   = google_secret_manager_secret_version.certificate.secret
  ssl_private_key_secret_id   = google_secret_manager_secret_version.key.secret
  data_disk_size              = 200
  dataiku_setup_version       = local.dataiku_setup_version
  node_type                   = local.node_type
  okta_domain                 = ""
  oidc_client_id              = ""
  oidc_client_secret_name     = ""
  dss_admin_email             = ""
  apt_proxy_url               = ""
  sentinel_one_token_name     = ""
  tanium_tags                 = ""
  machine_type                = "n1-standard-2"
  dataiku_license_secret_name = "dataiku_license"

  gke_node_pools = {
    default = {
      max_node_count = 1
      machine_type   = "n1-standard-2"
      gpu_type       = null
      gpu_count      = 0
    }
  }

  ## To enable VM start and stop schedule
  # start_stop = {
  #   time_zone  = "Europe/Paris"
  #   start_time = "0 8 * * 1-5"
  #   stop_time  = "0 20 * * 1-5"
  # }

  ## Fusion: To import old-Dataiku instance data disk, GCS and BQ into a new deployed Dataiku
  # source_bigquery_dataset= {
  #   dataset_id = "namingconvention_bqd_dss"
  #   friendly_name = "Dataiku dataset"
  #   description = "This is the Dataiku dataset linked to your instance"
  #   location = "EU"
  # }
  # source_storage_bucket = {
  #     name = "namingconvention_gcs_dss"
  #     location = "EU"
  # }
  # source_data_disk = "regions/europe-west1/disks/namingconvention-dpk-dss-data"

  depends_on = [
    google_compute_subnetwork.proxy_only,
    google_compute_network_peering_routes_config.peering_routes,
  ]
}
