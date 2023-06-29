#!/bin/bash

set -xeou pipefail

project_id="gcp-wow-rwds-api-poc-dev"

# Get a list of existing Pub/Sub subscriptions
subscriptions=$(gcloud pubsub subscriptions list --project=$project_id --format="value(name)")

# Loop through each subscription and update its message retention duration
for subscription in $subscriptions; do
  echo "========== $subscription ========= "
  gcloud pubsub subscriptions update $subscription --project=$project_id --message-retention-duration=604800s
  echo "================================== "
done