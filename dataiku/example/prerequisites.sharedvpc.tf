# Shared VPC ressources
resource "google_compute_network" "main" {
  name                    = "shared-vpc"
  auto_create_subnetworks = false
  project                 = local.project_id
}

resource "google_compute_router" "router" {
  project = local.project_id
  name    = "nat-router"
  network = google_compute_network.main.name
  region  = local.region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 4.0"
  project_id                         = local.project_id
  region                             = local.region
  router                             = google_compute_router.router.name
  name                               = "nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

#Proxy-only Subnetwork
resource "google_compute_subnetwork" "proxy_only" {
  name          = "proxy-only"
  project       = local.project_id
  ip_cidr_range = "192.168.16.0/20"
  network       = google_compute_network.main.name
  region        = local.region
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
}

resource "google_compute_subnetwork" "main" {
  name          = "main"
  project       = local.project_id
  ip_cidr_range = "192.168.0.0/20"
  network       = google_compute_network.main.name
  region        = local.region
  purpose       = "PRIVATE"
  role          = "ACTIVE"
}

# Firewall rules

## allow all access from IAP and health check ranges
resource "google_compute_firewall" "fw_iap" {
  project       = google_compute_network.main.project
  name          = "health-check-and-iap"
  direction     = "INGRESS"
  network       = google_compute_network.main.name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  target_tags   = ["health-check-and-iap"]
  allow {
    protocol = "tcp"
  }
}

## allow http from proxy subnet to backends
resource "google_compute_firewall" "fw_ilb_to_backends" {
  project       = google_compute_network.main.project
  name          = "http-server"
  direction     = "INGRESS"
  network       = google_compute_network.main.name
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }
}

#optional
resource "google_compute_firewall" "rules" {
  project = local.project_id
  name    = "allow-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

# Cloud SQL configuration
## reserve global internal address range for the peering
resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  project       = local.project_id
  network       = google_compute_network.main.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
}

## establish VPC network peering connection using the reserved address range
resource "google_service_networking_connection" "main" {
  network                 = google_compute_network.main.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

#optional
resource "google_compute_network_peering_routes_config" "peering_routes" {
  peering              = google_service_networking_connection.main.peering
  project              = local.project_id
  network              = google_compute_network.main.name
  import_custom_routes = true
  export_custom_routes = true
}