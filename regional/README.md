# Terraform Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.20.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helpers"></a> [helpers](#module\_helpers) | github.com/osinfra-io/terraform-core-helpers//root | v0.1.2 |

## Resources

| Name | Type |
|------|------|
| [google_artifact_registry_repository.docker_remote](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository.docker_standard](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository.docker_virtual](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_artifact_registry_repository_iam_binding.docker_standard_writers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_binding) | resource |
| [google_artifact_registry_repository_iam_binding.docker_virtual_readers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam_binding) | resource |
| [terraform_remote_state.main](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_docker_repositories"></a> [docker\_repositories](#input\_docker\_repositories) | The map of names and members for the Docker artifact registry repositories | <pre>map(object({<br/>    registry_readers = optional(list(string))<br/>    registry_writers = optional(list(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_docker_remote_repository"></a> [enable\_docker\_remote\_repository](#input\_enable\_docker\_remote\_repository) | Enable the Docker remote repository | `bool` | `false` | no |
| <a name="input_remote_bucket"></a> [remote\_bucket](#input\_remote\_bucket) | The remote bucket the `terraform_remote_state` data source retrieves the state from | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
