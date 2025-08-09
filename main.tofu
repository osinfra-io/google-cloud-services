terraform {

  # Requiring Providers
  # https://opentofu.org/docs/language/providers/requirements#requiring-providers

  required_providers {

    # Datadog Provider
    # https://search.opentofu.org/provider/DataDog/datadog/latest/docs

    datadog = {
      source = "datadog/datadog"
    }

    # Google Cloud Platform Provider
    # https://search.opentofu.org/provider/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Google Cloud Provider
# https://search.opentofu.org/provider/hashicorp/google/latest/docs

# This is only needed during bootstrapping.

# provider "google" {
#   billing_project       = var.billing_project
#   user_project_override = true
# }

# Datadog Google Cloud Platform Integration Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-datadog-google-integration

module "datadog" {
  source = "github.com/osinfra-io/opentofu-datadog-google-integration?ref=v0.3.6"
  count  = var.datadog_enable ? 1 : 0

  api_key                      = var.datadog_api_key
  enable_cloud_cost_management = var.datadog_enable_cloud_cost_management
  labels                       = module.helpers.labels
  project                      = module.project.id
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/opentofu-google-project

module "project" {
  source = "github.com/osinfra-io/opentofu-google-project?ref=v0.4.6"

  billing_account                 = var.project_billing_account
  cis_2_2_logging_sink_project_id = var.project_cis_2_2_logging_sink_project_id
  description                     = "services"
  folder_id                       = var.project_folder_id
  labels                          = module.helpers.labels
  monthly_budget_amount           = var.project_monthly_budget_amount
  prefix                          = "plt-lz"

  services = [
    "artifactregistry.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
    "bigquery.googleapis.com",
    "cloudasset.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "securitycenter.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}
