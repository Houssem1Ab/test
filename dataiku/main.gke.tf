module "gke" {
  for_each = toset(length(var.gke_node_pools) == 0 ? [] : [var.name])

  source = "../gke"

  format_map    = merge(var.format_map, { sac = "$${name}" })
  format_values = var.format_values

  name       = local.name
  project_id = var.project_id
  location   = var.location
  region     = var.region
  zone       = var.zone

  node_pools = {
    for name, settings in var.gke_node_pools :
    name => {
      max_node_count = settings.max_node_count
      machine_type   = settings.machine_type
      gpu_type       = settings.gpu_type
      gpu_count      = settings.gpu_count
      taint = concat([
        {
          key    = "REQUEST"
          value  = "DSS"
          effect = "NO_SCHEDULE"
        }
        ], settings.gpu_count == 0 ? [] : [
        {
          key    = "nvidia.com/gpu"
          value  = "present"
          effect = "NO_SCHEDULE"
        }
      ])
    }
  }
}
