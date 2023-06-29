output "trigger_auditlog_tf_pubsub" {
  value = google_eventarc_trigger.trigger_auditlog_tf.transport[0].pubsub[0].subscription
}

output "trigger_pubsub_tf_pubsub" {
  value = google_eventarc_trigger.trigger_pubsub_tf.transport[0].pubsub[0].subscription
}