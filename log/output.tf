output "firewall_rule_id" {
  description = "Your firewall rule id output"
  value = google_compute_firewall.default.id #google_compute_firewall.google_compute_firewall.firewall_rule.id
}


output "firewall_rule_details" {
  value = google_compute_firewall.default
}