## edit using gcloud cli

assume pubsub subscriptions is `projects/gcp-wow-rwds-api-poc-dev/subscriptions/eventarc-australia-southeast1-trigger-auditlog-tf-sub-444`
```
gcloud pubsub subscriptions describe projects/gcp-wow-rwds-api-poc-dev/subscriptions/eventarc-australia-southeast1-trigger-auditlog-tf-sub-444
gcloud pubsub subscriptions update projects/gcp-wow-rwds-api-poc-dev/subscriptions/eventarc-australia-southeast1-trigger-auditlog-tf-sub-444  --message-retention-duration=604800
```


https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/eventarc_trigger

```
The pubsub block supports:

subscription - Output only. The name of the Pub/Sub subscription created and managed by Eventarc system as a transport for the event delivery. Format: projects/{PROJECT_ID}/subscriptions/{SUBSCRIPTION_NAME}.

topic - (Optional) Optional. The name of the Pub/Sub topic created and managed by Eventarc system as a transport for the event delivery. Format: projects/{PROJECT_ID}/topics/{TOPIC_NAME}. You may set an existing topic for triggers of the type google.cloud.pubsub.topic.v1.messagePublished only. The topic you provide here will not be deleted by Eventarc at trigger deletion.

```