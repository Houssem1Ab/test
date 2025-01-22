module "host_sac_name" {
  source = "../utils/naming"

  format_map    = { sac = "$${name}" } # cannot use default naming convention due to resource name size limit
  format_values = var.format_values

  type_trigram = "sac"
  name         = "${local.name}-host"
}

module "data_sac_name" {
  source = "../utils/naming"

  format_map    = { sac = "$${name}" } # cannot use default naming convention due to resource name size limit
  format_values = var.format_values

  type_trigram = "sac"
  name         = "${local.name}-data"
}

module "gce_start_stop_policy_name" {
  for_each = toset(var.start_stop == null ? [] : [var.name])

  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "crp"
  name         = "${local.name}-start-stop"
}

module "gce_disk_snapshot_policy_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "crp"
  name         = "${local.name}-disk-snapshot"
}

module "data_disk_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "dpk"
  name         = "${local.name}-data"
}

module "gce_name" {
  source = "../utils/naming"

  format_map = var.format_map
  format_values = merge(var.format_values, {
    os_type = "ubuntu"
    number  = "01"
  })

  type_trigram = "gce"
  name         = local.name
}

resource "google_service_account" "host_sac" {
  account_id   = module.host_sac_name.kebabCase
  display_name = "Dataiku Host Service Account"
  project      = var.project_id
}

resource "google_project_iam_custom_role" "dataiku_cloud_run_jobs" {
  project     = var.project_id
  role_id     = "${replace(var.project_id, "/[\\s_\\- ]+/", ".")}.${replace(local.name, "/[\\s_\\- ]+/", ".")}.cr.jobs" # Role ID must be unique within the organization
  title       = "Dataiku Cloud Run Jobs"
  description = "Allows Dataiku to create and run Cloud Run jobs (used in Atom plugins recipes)"
  permissions = [
    "run.jobs.create",
    "run.jobs.update",
    "run.jobs.get",
    "run.jobs.run",
    "run.jobs.runWithOverrides",
    "run.operations.get"
  ]
}

resource "google_project_iam_member" "host_sac_cr_role" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.host_sac.email}"
  role    = google_project_iam_custom_role.dataiku_cloud_run_jobs.id
}

resource "google_project_iam_member" "host_sac_roles" {
  for_each = toset(concat([
    "logging.logWriter",
    "monitoring.metricWriter",
    "compute.admin",
    "iam.serviceAccountUser",
    "storage.objectAdmin",
    "secretmanager.secretAccessor",
    "iam.serviceAccountViewer",
    "storage.admin",
    ], local.cluster == null ? [] : [
    "containerregistry.ServiceAgent",
    "container.clusterAdmin",
    "container.admin",
    "artifactregistry.writer"
  ]))

  project = var.project_id
  member  = "serviceAccount:${google_service_account.host_sac.email}"
  role    = "roles/${each.value}"
}

resource "google_project_iam_member" "host_sac_cloudsqlclient_role" {
  project = var.cloud_sql_instance_connection_name != "" ? split(":", var.cloud_sql_instance_connection_name)[0] : var.project_id
  member  = "serviceAccount:${google_service_account.host_sac.email}"
  role    = "roles/cloudsql.client"
}

resource "google_service_account" "data_sac" {
  account_id   = module.data_sac_name.kebabCase
  display_name = "Dataiku Data Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "data_sac_roles" {
  for_each = toset([
    "bigquery.user",
    "bigquery.readSessionUser",
    "bigquery.dataEditor",
    "storage.objectAdmin",
    "storage.admin",
  ])

  project = var.project_id
  member  = "serviceAccount:${google_service_account.data_sac.email}"
  role    = "roles/${each.value}"
}

resource "google_compute_resource_policy" "start_stop_policy" {
  for_each = module.gce_start_stop_policy_name

  name    = each.value.kebabCase
  project = var.project_id
  region  = var.region

  instance_schedule_policy {
    time_zone = var.start_stop.time_zone
    vm_start_schedule {
      schedule = var.start_stop.start_time
    }
    vm_stop_schedule {
      schedule = var.start_stop.stop_time
    }
  }
}

resource "google_compute_resource_policy" "snapshot_policy" {
  name    = module.gce_disk_snapshot_policy_name.kebabCase
  project = var.project_id
  region  = var.region

  snapshot_schedule_policy {
    schedule {
      hourly_schedule {
        start_time     = "00:00"
        hours_in_cycle = 12
      }
    }
    retention_policy {
      max_retention_days = 7
    }
    snapshot_properties {
      storage_locations = [var.region]
    }
  }
}

resource "google_compute_region_disk" "data_disk" {
  name          = module.data_disk_name.kebabCase
  replica_zones = slice(compact(local.compute_data_disk_zones), 0, 2)
  project       = var.project_id
  region        = local.compute_data_disk_region
  size          = var.data_disk_size
  type          = local.compute_data_disk_type
  source_disk   = try(local.source_data_disk, null)
  lifecycle {
    ignore_changes = [replica_zones]
  }
}

resource "google_compute_region_disk_resource_policy_attachment" "data_disk_snapshot_policy" {
  name    = google_compute_resource_policy.snapshot_policy.name
  disk    = google_compute_region_disk.data_disk.name
  region  = var.region
  project = var.project_id
}

resource "google_service_account_key" "data_sac_key" {
  service_account_id = google_service_account.data_sac.name
}

resource "google_compute_instance" "main" {
  name                      = module.gce_name.kebabCase
  machine_type              = var.machine_type
  zone                      = var.zone
  project                   = var.project_id
  allow_stopping_for_update = true

  resource_policies = try([google_compute_resource_policy.start_stop_policy[var.name].self_link], [])
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      type  = "pd-standard"
      size  = 200
    }
  }
  attached_disk {
    source      = google_compute_region_disk.data_disk.self_link
    device_name = "data-drive"
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.shared.self_link
  }
  dynamic "network_interface" {
    for_each = toset(try([local.cluster.name], []))
    content {
      subnetwork = local.cluster.subnet.self_link
    }

  }

  tags                    = concat(["http-server", "health-check-and-iap", "allow-required-connections"], try(local.cluster.network_tags, []))
  metadata                = local.gce_metadata
  metadata_startup_script = local.gce_startup_script
  service_account {
    email = google_service_account.host_sac.email
    scopes = [
      "cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/sqlservice.admin",
    ]
  }
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  lifecycle {
    ignore_changes = [labels, tags]
  }
}
