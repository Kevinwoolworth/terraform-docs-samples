provider "google" {
  region = "australia-southeast1-a"
}

resource "google_monitoring_notification_channel" "email-me" {
  project      = "gcp-wow-rwds-data-poc-dev"
  display_name = "Email Me"
  type         = "email"
  labels = {
    email_address = "me@mycompany.com"
  }
}

resource "google_monitoring_alert_policy" "workflows" {
  project      = "gcp-wow-rwds-data-poc-dev"
  display_name = "Workflows alert policy"
  combiner     = "OR"
  conditions {
    display_name = "Error condition"
    condition_matched_log {
      filter = "resource.type=\"workflows.googleapis.com/Workflow\" severity=ERROR"
    }
  }

  notification_channels = [google_monitoring_notification_channel.email-me.name]
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

#resource "google_monitoring_alert_policy" "alert_policy" {
#  project      = "gcp-wow-rwds-data-poc-dev"
#  display_name = "My Alert Policy"
#  combiner     = "OR"
#  conditions {
#    display_name = "test condition"
#    condition_threshold {
#      filter          = "metric.type=\"logging.googleapis.com/user/test-metrics\" AND resource.type=\"cloud_run_revision\""
#      duration        = "600s"
#      comparison      = "COMPARISON_GT"
#      threshold_value = 1
#    }
#  }
#
#  user_labels = {
#    foo = "bar"
#  }
#}

#resource "google_logging_metric" "my_log_metrics" {
#  project = "gcp-wow-rwds-data-poc-dev"
#  name = "my-log-metric"
#  filter = "..."
#  description = "..."
#  metric_descriptor {
#    metric_kind = "..."
#    value_type = "..."
#  }
#}

resource "google_logging_metric" "logging_metric" {
  project = "gcp-wow-rwds-data-poc-dev"
  name    = "my-progress/metric"
  filter  = "resource.type=\"gce_subnetwork\" AND json_payload.rule_details.reference=\"network:gcp-wow-rwds-data-poc-dev/firewall:postgres-proxy\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

#resource "google_monitoring_alert_policy" "my_policy" {
#  project = "gcp-wow-rwds-data-poc-dev"
#  display_name = "my-policy"
#  combiner = "OR"
#  conditions {
#    display_name = "my-policy"
#    condition_threshold {
#      filter = "metric.type=\"logging.googleapis.com/user/my-log-metric\" AND resource.type=\"cloud_composer_environment\""
#    }
#  }
#}

#resource "google_compute_firewall" "terraform" {
#  name    = "terraform-firewall"
#  network = "default"
#
#  allow {
#    protocol = "icmp"
#  }
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80", "8800", "443", "22"]
#  }
#}

resource "google_compute_firewall" "default" {
  project = "gcp-wow-rwds-data-poc-dev"
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_network" "default" {
  project = "gcp-wow-rwds-data-poc-dev"
  name    = "test-network"
}