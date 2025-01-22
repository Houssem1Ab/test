locals {
  name    = "dss-${var.name}"
  cluster = length(module.gke) == 0 ? null : module.gke[var.name]
  gce_metadata = merge({
    enable-guest-attributes     = "TRUE"
    enable-osconfig             = "TRUE"
    default_bq_dataset          = google_bigquery_dataset.main.dataset_id
    default_gcs_bucket          = google_storage_bucket.main.name
    keys_data                   = google_service_account_key.data_sac_key.private_key
    log_level                   = "INFO"
    atom_dataiku_setup_version  = var.dataiku_setup_version
    instance_state              = "NOT_PROVISIONED"
    node_type                   = var.node_type
    okta_domain                 = var.okta_domain
    oidc_client_id              = var.oidc_client_id
    oidc_client_secret_name     = var.oidc_client_secret_name
    dss_admin_email             = var.dss_admin_email
    gke_enabled                 = local.cluster == null ? false : true
    cloud_sql_connection_name   = var.cloud_sql_instance_connection_name != "" ? var.cloud_sql_instance_connection_name : google_sql_database_instance.main[0].connection_name
    cloud_sql_secret_id         = var.cloud_sql_dataiku_password_secret_name != "" ? var.cloud_sql_dataiku_password_secret_name : regex("projects/(?P<project>[\\w-]+)/secrets/(?P<name>[\\w-]+)/versions/(?P<version>[\\w-]+)", google_secret_manager_secret_version.cloudsql_password[0].id)["name"]
    cloud_sql_database_name     = google_sql_database.database.name
    proxy_url                   = var.apt_proxy_url
    sentinel_one_token_name     = var.sentinel_one_token_name
    tanium_tags                 = var.tanium_tags
    dataiku_license_secret_name = var.dataiku_license_secret_name
    }, local.cluster == null ? {} : {
    gke_cluster_name     = local.cluster.name
    gke_cluster_location = local.cluster.location
    gke_cidr             = local.cluster.network_cidr
    gke_nodepools = jsonencode({
      for key, pool_name in local.cluster.node_pool_names :
      pool_name => var.gke_node_pools[key].gpu_count == 0 ? "cpu" : "gpu"
    })
  })
  gce_startup_script       = <<EOT
#! /bin/bash
echo "[ATM][startup_script] Starting startup script"
rm -rf atom-dataiku-setup
ATOM_DATAIKU_SETUP_VERSION=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/atom_dataiku_setup_version -H "Metadata-Flavor: Google")
echo "[ATM][startup_script] Clone $${ATOM_DATAIKU_SETUP_VERSION} atom dataiku setup scripts"
git clone --branch $${ATOM_DATAIKU_SETUP_VERSION} https://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@github.com/lvmh-data/atom-dataiku-setup.git
cd atom-dataiku-setup
echo "[ATM][startup_script] Launching $${ATOM_DATAIKU_SETUP_VERSION} atom dataiku setup scripts"
bash setup.sh
  EOT
  source_data_disk         = var.source_data_disk != null ? var.source_data_disk : ""
  zonal_source_disk        = length(data.google_compute_disk.fusion-source-disk) > 0
  compute_data_disk_region = local.zonal_source_disk ? join("-", slice(split("-", data.google_compute_disk.fusion-source-disk[0].zone), 0, length(split("-", data.google_compute_disk.fusion-source-disk[0].zone)) - 1)) : startswith(local.source_data_disk, "region") ? element(split("/", local.source_data_disk), 1) : var.region
  compute_data_disk_type   = local.zonal_source_disk ? data.google_compute_disk.fusion-source-disk[0].type : var.source_data_disk_type
  compute_data_disk_zones = flatten([
    local.zonal_source_disk ? data.google_compute_disk.fusion-source-disk[0].zone : null,
    tolist(setsubtract(data.google_compute_zones.available.names, local.zonal_source_disk ? [data.google_compute_disk.fusion-source-disk[0].zone] : []))
  ])
}
