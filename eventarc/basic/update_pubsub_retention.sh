#!/bin/bash

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