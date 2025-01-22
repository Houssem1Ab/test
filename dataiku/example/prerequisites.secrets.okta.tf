resource "google_secret_manager_secret" "oidc_client_secret_name" {
  secret_id = "oidc_client_secret_name"
  project   = local.project_id
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "oidc_client_secret_name" {
  secret      = google_secret_manager_secret.oidc_client_secret_name.id
  secret_data = "oidc_client_secret_value"
}