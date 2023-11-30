name                = "nodejs-on-fargate"
environment         = "dev"
availability_zones  = ["eu-west-1a", "eu-west-1b"]
private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
tsl_certificate_arn = "mycertificatearn"
container_memory    = 512

aws-access-key = "AKIAYFOUHBXWPM4TFIFY"
aws-secret-key = "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"
application-secrets = {
  "ENV"                    = "dev"
  "SOLARIS_WEBHOOK_SECRET" = "my-solaris-webhook-secret"
  "DYNAMO_DB_KEY"          = "my-dynamo-db-key"
  "DYNAMO_DB_SECRET"       = "my-dynamo-db-secret"
  "API_KEY_X"              = "my-api-key"
}
