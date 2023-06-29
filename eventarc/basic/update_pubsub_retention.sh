#!/bin/bash

# To create a Codefresh pipeline with a cron trigger, you need to define the pipeline configuration in a codefresh.yml file within your repository.
# ============================================
#
#version: '1.0'
#
#pipelines:
#  cron_job_pipeline:
#    schedule:
#      cron: '0 0 * * *'  # Schedule the pipeline to run daily at midnight (UTC)
#    steps:
#      - name: step1
#        image: alpine:latest
#        commands:
#          - sh path/to/your/update_pubsub_retention.sh
# ============================================



set -eou pipefail

project_id="gcp-wow-rwds-api-poc-dev"

# Get a list of existing Pub/Sub subscriptions
subscriptions=$(gcloud pubsub subscriptions list --project=$project_id --format="value(name)")

# Loop through each subscription and update its message retention duration
for subscription in $subscriptions; do
 # Get the existing message retention duration
  retention_duration=$(gcloud pubsub subscriptions describe $subscription --project=$project_id --format="value(messageRetentionDuration)")
  echo "-------------------------------------------------------"
  # Print the existing retention duration
  echo "Existing message retention duration for '$subscription': '$retention_duration'"

  # Check if the retention duration is not already set to 7 days
  if [[ $retention_duration != "604800s" ]]; then
    echo "Updating message retention duration for '$subscription' to 7 days..."

    # Update the message retention duration
    gcloud pubsub subscriptions update $subscription --project=$project_id --message-retention-duration=604800s

    echo "Message retention duration updated for '$subscription'"
  else
    echo "Retention duration already set to 7 days for '$subscription'"
  fi

  echo "======================================================"
done