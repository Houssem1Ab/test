output "forwarding_rule_ip" {
  value = google_compute_forwarding_rule.https.ip_address
}