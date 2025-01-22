module "bucket_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "gcs"
  name         = local.name
}

resource "google_storage_bucket" "main" {
  name                        = try(var.source_storage_bucket.name, module.bucket_name.snakeCase)
  project                     = var.project_id
  location                    = try(var.source_storage_bucket.location, var.location)
  uniform_bucket_level_access = true

  force_destroy = false
}
