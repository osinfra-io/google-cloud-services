# Required Providers
# https://opentofu.org/docs/language/providers/requirements#requiring-providers

terraform {
  # State and Plan Encryption
  # https://opentofu.org/docs/language/state/encryption

  # The commented out sections below demonstrate how to configure
  # fallback encryption methods for state and plan files for bootstrapping.

  encryption {
    method "unencrypted" "migrate" {}

    key_provider "gcp_kms" "default" {
      kms_encryption_key = var.state_kms_encryption_key
      key_length         = 32
    }

    method "aes_gcm" "default" {
      keys = key_provider.gcp_kms.default
    }

    plan {
      method = method.aes_gcm.default
      # enforced = true

      fallback {
        method = method.unencrypted.migrate
      }
    }

    remote_state_data_sources {
      default {
        method = method.aes_gcm.default
      }
    }

    state {
      method = method.aes_gcm.default
      # enforced = true

      fallback {
        method = method.unencrypted.migrate
      }
    }
  }

  required_providers {

    # Google Cloud Provider
    # https://search.opentofu.org/provider/hashicorp/google/latest/docs

    google = {
      source = "hashicorp/google"
    }
  }
}

# OpenTofu Remote State Datasource
# https://opentofu.org/docs/language/state/remote-state-data/

data "terraform_remote_state" "main" {
  backend = "gcs"

  config = {
    bucket             = var.remote_bucket
    kms_encryption_key = var.state_kms_encryption_key
    prefix             = "google-cloud-services"
  }

  workspace = "main-${module.helpers.environment}"
}

# Google Artifact Registry Repository
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/resources/artifact_registry_repository

resource "google_artifact_registry_repository" "docker_standard" {
  for_each = var.docker_repositories

  description   = "Registry for multi-region - US Standard : ${each.key}"
  format        = "DOCKER"
  labels        = module.helpers.labels
  location      = "us"
  project       = local.main.project_id
  repository_id = "${each.key}-standard"
}

resource "google_artifact_registry_repository" "docker_remote" {
  count = var.enable_docker_remote_repository ? 1 : 0

  description = "Registry for multi-region - US Docker Hub"
  format      = "DOCKER"
  labels      = module.helpers.labels
  location    = "us"
  mode        = "REMOTE_REPOSITORY"
  project     = local.main.project_id

  remote_repository_config {
    description = "docker hub"
    docker_repository {
      public_repository = "DOCKER_HUB"
    }
  }

  repository_id = "docker-remote"
}

resource "google_artifact_registry_repository" "docker_virtual" {
  for_each = var.docker_repositories

  description   = "Registry for multi-region - US Virtual : ${each.key}"
  format        = "DOCKER"
  labels        = module.helpers.labels
  location      = "us"
  mode          = "VIRTUAL_REPOSITORY"
  project       = local.main.project_id
  repository_id = "${each.key}-virtual"

  virtual_repository_config {
    upstream_policies {
      id         = each.key
      priority   = 20
      repository = google_artifact_registry_repository.docker_standard[each.key].id
    }

    upstream_policies {
      id         = "docker"
      priority   = 10
      repository = google_artifact_registry_repository.docker_remote[0].id
    }
  }
}

# Google Artifact Registry IAM Binding
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam

resource "google_artifact_registry_repository_iam_binding" "docker_virtual_readers" {
  for_each = var.docker_repositories

  location   = "us"
  project    = local.main.project_id
  repository = google_artifact_registry_repository.docker_virtual[each.key].id
  role       = "roles/artifactregistry.reader"
  members    = each.value.registry_readers
}

resource "google_artifact_registry_repository_iam_binding" "docker_standard_writers" {
  for_each = var.docker_repositories

  location   = "us"
  project    = local.main.project_id
  repository = google_artifact_registry_repository.docker_standard[each.key].id
  role       = "roles/artifactregistry.writer"
  members    = each.value.registry_writers
}

resource "null_resource" "force_apply" {
  triggers = {
    always_run = timestamp()
  }
}
