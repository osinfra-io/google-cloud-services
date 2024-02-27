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
  source = "github.com/osinfra-io/terraform-datadog-google-integration//global?ref=v0.1.3"
  count  = var.enable_datadog ? 1 : 0

  api_key                      = var.datadog_api_key
  cost_center                  = "x001"
  enable_cloud_cost_management = var.enable_datadog_cloud_cost_management
  is_cspm_enabled              = true


  labels = {
    env        = var.environment
    repository = "google-cloud-services"
    platform   = "google-cloud-landing-zone"
    team       = "platform-google-cloud-landing-zone"
  }

  project = module.project.project_id
}

# Google Project Module (osinfra.io)
# https://github.com/osinfra-io/terraform-google-project

module "project" {
  source = "github.com/osinfra-io/terraform-google-project//global?ref=v0.1.9"

  billing_account                 = var.billing_account
  cis_2_2_logging_sink_project_id = var.cis_2_2_logging_sink_project_id
  cost_center                     = "x001"
  description                     = "services"
  environment                     = var.environment
  folder_id                       = var.folder_id

  labels = {
    env        = var.environment
    repository = "google-cloud-services"
    platform   = "google-cloud-landing-zone"
    team       = "platform-google-cloud-landing-zone"
  }

  prefix = "plt-lz"

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
