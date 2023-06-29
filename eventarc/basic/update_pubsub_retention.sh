#!/bin/bash

set -xeou pipefail

project_id="your-project-id"

# Get a list of existing Pub/Sub subscriptions
subscriptions=$(gcloud pubsub subscriptions list --project=$project_id --format="value(name)")

# Loop through each subscription and update its message retention duration
for subscription in $subscriptions; do
  gcloud pubsub subscriptions update $subscription --project=$project_id --message-retention-duration=604800s
done