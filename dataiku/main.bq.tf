module "dataset_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "bqd"
  name         = local.name
}

resource "google_bigquery_dataset" "main" {
  dataset_id                  = try(var.source_bigquery_dataset.dataset_id, module.dataset_name.snakeCase)
  location                    = try(var.source_bigquery_dataset.location, var.location)
  project                     = var.project_id
  friendly_name               = try(var.source_bigquery_dataset.friendly_name, "Dataiku dataset")
  description                 = try(var.source_bigquery_dataset.description, "This is the Dataiku dataset linked to your instance")
  default_table_expiration_ms = null
  labels                      = null

  delete_contents_on_destroy = false
}
