# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  env = lookup(local.env_map, var.environment, "none")

  env_map = {
    "non-production" = "non-prod"
    "production"     = "prod"
    "sandbox"        = "sb"
  }

  labels = {
    cost-center = "x001"
    env         = var.environment
    repository  = "google-cloud-services"
    platform    = "google-cloud-landing-zone"
    team        = "platform-google-cloud-landing-zone"
  }
}
