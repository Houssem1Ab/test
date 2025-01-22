module "cloudsql_password_secret_name" {
  count  = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-cloudsql-password"
}

module "cloudsql_instance_name" {
  count  = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "sql"
  name         = local.name
}

module "cloudsql_database_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "sql"
  name         = local.name
}

resource "random_password" "cloudsql_password" {
  count   = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  length  = 12
  special = false
}

resource "random_id" "cloudsql_instance_id" {
  count       = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  byte_length = 2
}

resource "google_secret_manager_secret" "cloudsql_password" {
  count     = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  secret_id = module.cloudsql_password_secret_name[0].snakeCase
  project   = var.project_id
  replication {

    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "cloudsql_password" {
  count       = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  secret      = google_secret_manager_secret.cloudsql_password[0].id
  secret_data = random_password.cloudsql_password[0].result
}

resource "google_sql_database_instance" "main" {
  count            = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  name             = module.cloudsql_instance_name[0].kebabCase
  project          = var.project_id
  database_version = "POSTGRES_15"
  region           = var.region
  settings {
    tier              = "db-custom-1-3840"
    availability_type = "ZONAL"
    disk_autoresize   = true
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.shared.self_link
      require_ssl     = true
    }
    backup_configuration {
      enabled                        = true
      start_time                     = "22:00"
      point_in_time_recovery_enabled = true
      location                       = var.region
      transaction_log_retention_days = 7
    }
    location_preference {
      zone = var.zone
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = module.cloudsql_database_name.kebabCase
  instance = var.cloud_sql_instance_connection_name != "" ? split(":", var.cloud_sql_instance_connection_name)[2] : google_sql_database_instance.main[0].name
  project  = var.cloud_sql_instance_connection_name != "" ? split(":", var.cloud_sql_instance_connection_name)[0] : var.project_id
}

resource "google_sql_user" "dataiku" {
  count           = var.cloud_sql_instance_connection_name == "" ? 1 : 0
  name            = "dataiku"
  project         = var.project_id
  instance        = google_sql_database_instance.main[0].name
  password        = random_password.cloudsql_password[0].result
  deletion_policy = "ABANDON"
}
