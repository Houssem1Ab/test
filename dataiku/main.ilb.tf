module "instance_group_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "cig"
  name         = local.name
}

module "certificate_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "cig"
  name         = local.name
}

module "health_check_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-health-check"
}

module "backend_service_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-backend-service"
}

module "main_url_map_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-main"
}

module "redirect_url_map_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-redirect"
}

module "https_proxy_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-https-proxy"
}

module "compute_address_name" {
  source = "../utils/naming"

  format_map    = var.format_map
  format_values = var.format_values

  type_trigram = "iip"
  name         = local.name
}

module "https_forwarding_rule_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-https-forwarding"
}

module "http_proxy_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-http-proxy"
}

module "http_forwarding_rule_name" {
  source = "../utils/naming"

  format_map    = { _ = "$${lower(name)}" }
  format_values = var.format_values

  type_trigram = "_"
  name         = "${local.name}-http-forwarding"
}

resource "google_compute_instance_group" "main" {
  name      = module.instance_group_name.kebabCase
  project   = var.project_id
  zone      = var.zone
  instances = [google_compute_instance.main.self_link]
  named_port {
    name = "http-dataiku"
    port = 8080
  }
}

resource "google_compute_region_ssl_certificate" "main" {
  name_prefix = "${module.certificate_name.kebabCase}-"
  project     = var.project_id
  region      = var.region
  certificate = data.google_secret_manager_secret_version.ssl_certificate.secret_data
  private_key = data.google_secret_manager_secret_version.ssl_private_key.secret_data
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_health_check" "main" {
  name                = module.health_check_name.kebabCase
  project             = var.project_id
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
  http_health_check {
    port               = 8080
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
    request_path       = "/"
  }
}

resource "google_compute_region_backend_service" "main" {
  name                  = module.backend_service_name.kebabCase
  project               = var.project_id
  region                = var.region
  health_checks         = [google_compute_health_check.main.self_link]
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_name             = "http-dataiku"
  protocol              = "HTTP"
  timeout_sec           = 30
  backend {
    group           = google_compute_instance_group.main.self_link
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1
  }
}

resource "google_compute_region_url_map" "main" {
  name            = module.main_url_map_name.kebabCase
  project         = var.project_id
  region          = var.region
  default_service = google_compute_region_backend_service.main.self_link
}

resource "google_compute_region_target_https_proxy" "main" {
  name             = module.https_proxy_name.kebabCase
  project          = var.project_id
  region           = var.region
  url_map          = google_compute_region_url_map.main.self_link
  ssl_certificates = [google_compute_region_ssl_certificate.main.self_link]
  lifecycle {
    ignore_changes = [ssl_certificates]
  }
}

resource "google_compute_address" "main" {
  name         = module.compute_address_name.kebabCase
  project      = var.project_id
  region       = var.region
  address_type = "INTERNAL"
  purpose      = "SHARED_LOADBALANCER_VIP"
  subnetwork   = data.google_compute_subnetwork.shared.self_link
}

resource "google_compute_forwarding_rule" "https" {
  name                  = module.https_forwarding_rule_name.kebabCase
  project               = var.project_id
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  ip_protocol           = "TCP"
  port_range            = "443"
  target                = google_compute_region_target_https_proxy.main.self_link
  subnetwork            = data.google_compute_subnetwork.shared.self_link
  ip_address            = google_compute_address.main.self_link
}

resource "google_compute_region_url_map" "redirect" {
  name    = module.redirect_url_map_name.kebabCase
  project = var.project_id
  region  = var.region
  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
    https_redirect         = true
  }
}

resource "google_compute_region_target_http_proxy" "main" {
  name    = module.http_proxy_name.kebabCase
  project = var.project_id
  region  = var.region
  url_map = google_compute_region_url_map.redirect.self_link
}

resource "google_compute_forwarding_rule" "http" {
  name                  = module.http_forwarding_rule_name.kebabCase
  project               = var.project_id
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.main.self_link
  subnetwork            = data.google_compute_subnetwork.shared.self_link
  ip_address            = google_compute_address.main.self_link
}
