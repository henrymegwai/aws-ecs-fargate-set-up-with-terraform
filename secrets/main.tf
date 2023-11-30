# This file creates secrets in the AWS Secret Manager
# Note that this does not contain any actual secret values
# make sure to not commit any secret values to git!
# you could put them in secrets.tfvars which is in .gitignore
locals {
  aws-access-key = "AKIAYFOUHBXWPM4TFIFY"
  aws-secret-key = "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"
  application-secrets = {
    "ENV"                    = "dev"
    "SOLARIS_WEBHOOK_SECRET" = "my-solaris-webhook-secret"
    "DYNAMO_DB_KEY"          = "my-dynamo-db-key"
    "DYNAMO_DB_SECRET"       = "my-dynamo-db-secret"
    "API_KEY_X"              = "my-api-key"
  }
}

resource "aws_secretsmanager_secret" "application_secrets" {
  count = length(local.application-secrets)
  name  = "${var.name}-application-secrets-${var.environment}-${element(keys(local.application-secrets), count.index)}"
}


resource "aws_secretsmanager_secret_version" "application_secrets_values" {
  count         = length(local.application-secrets)
  secret_id     = element(aws_secretsmanager_secret.application_secrets.*.id, count.index)
  secret_string = element(values(local.application-secrets), count.index)
}

locals {
  secrets = zipmap(keys(local.application-secrets), aws_secretsmanager_secret_version.solaris_broker_application_secrets_values.*.arn)

  secretMap = [for secretKey in keys(local.application-secrets) : {
    name      = secretKey
    valueFrom = lookup(local.secrets, secretKey)
    }

  ]
}

# output "application_secrets_arn" {
#   value = aws_secretsmanager_secret_version.solaris_broker_application_secrets_values.*.arn
# }

output "secrets_map" {
  value = local.secretMap
}

