terraform {

  # Requiring Providers
  # https://www.terraform.io/language/providers/requirements#requiring-providers

  required_providers {

    # Datadog Provider
    # https://registry.terraform.io/providers/DataDog/datadog/latest/docs

    datadog = {
      source = "datadog/datadog"
    }

    # Google Cloud Platform Provider
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Datadog Google Cloud Platform Integration Module (osinfra.io)
# https://github.com/osinfra-io/terraform-datadog-google-integration

module "datadog" {
  source = "github.com/osinfra-io/terraform-datadog-google-integration?ref=v0.2.1"
  count  = var.enable_datadog ? 1 : 0

  api_key                            = var.datadog_api_key
  enable_cloud_cost_management       = var.enable_datadog_cloud_cost_management
  is_security_command_center_enabled = true
  is_cspm_enabled                    = true
  labels                             = local.labels
  project                            = module.project.project_id
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "project" {
  source = "github.com/osinfra-io/terraform-google-project?ref=v0.3.1"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  description                     = "services"
  environment                     = local.env
  folder_id                       = var.folder_id
  labels                          = local.labels
  monthly_budget_amount           = var.monthly_budget_amount
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
  ]
}
