# <img align="left" width="45" height="45" src="https://user-images.githubusercontent.com/1610100/196006051-0ce38983-ffc9-4d5d-bf41-1da0b5e0fd6e.png">Google Cloud Platform - Services

**[GitHub Actions](https://github.com/osinfra-io/google-cloud-services/actions):**

[![Dependabot](https://github.com/osinfra-io/google-cloud-services/actions/workflows/dependabot.yml/badge.svg)](https://github.com/osinfra-io/google-cloud-services/actions/workflows/dependabot.yml)

**[Infracost](https://www.infracost.io):**

[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/cbeecfe3-576f-4553-984c-e451a575ee47/repos/a97cbc40-a50a-4371-9365-a89a1e4bb09a/branch/c27aeced-0f9b-4942-b28e-b03f70d107d6)](https://dashboard.infracost.io/org/osinfra-io/repos/a97cbc40-a50a-4371-9365-a89a1e4bb09a?tab=settings)

💵 Monthly estimates based on Infracost baseline costs.

## 📄 Repository Description

This repository configures common services that aligns with our [Google Cloud landing zone platform](https://docs.osinfra.io/google-cloud-platform/landing-zone) design. A landing zone should be a prerequisite to deploying enterprise workloads in a cloud environment.

## 🏭 Platform Information

- Documentation: [docs.osinfra.io](https://docs.osinfra.io/product-guides/google-cloud-platform/landing-zone/google-cloud-services)
- Service Interfaces: [github.com](https://github.com/osinfra-io/google-cloud-services/issues/new/choose)

## <img align="left" width="35" height="35" src="https://github.com/osinfra-io/github-organization-management/assets/1610100/39d6ae3b-ccc2-42db-92f1-276a5bc54e65"> Development

Our focus is on the core fundamental practice of platform engineering, Infrastructure as Code.

>Open Source Infrastructure (as Code) is a development model for infrastructure that focuses on open collaboration and applying relative lessons learned from software development practices that organizations can use internally at scale. - [Open Source Infrastructure (as Code)](https://www.osinfra.io)

To avoid slowing down stream-aligned teams, we want to open up the possibility for contributions. The Open Source Infrastructure (as Code) model allows team members external to the platform team to contribute with only a slight increase in cognitive load. This section is for developers who want to contribute to this repository, describing the tools used, the skills, and the knowledge required, along with Terraform documentation.

See the documentation for setting up a development environment [here](https://docs.osinfra.io/fundamentals/development-setup).

### 🛠️ Tools

- [checkov](https://github.com/bridgecrewio/checkov)
- [infracost](https://github.com/infracost/infracost)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [artifact-registry](https://cloud.google.com/artifact-registry/docs)

### 📓 Terraform Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


#### Modules

| Name | Source | Version |
|------|--------|---------|
| datadog | github.com/osinfra-io/terraform-datadog-google-integration | v0.2.1 |
| project | github.com/osinfra-io/terraform-google-project | v0.3.0 |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The alphanumeric ID of the billing account this project belongs to | `string` | `"01C550-A2C86B-B8F16B"` | no |
| cis\_2\_2\_logging\_sink\_project\_id | The CIS 2.2 logging sink benchmark project ID | `string` | n/a | yes |
| datadog\_api\_key | Datadog API key | `string` | n/a | yes |
| datadog\_app\_key | Datadog APP key | `string` | n/a | yes |
| enable\_datadog | Enable Datadog integration | `bool` | `false` | no |
| enable\_datadog\_cloud\_cost\_management | Enable Datadog cloud cost management | `bool` | `false` | no |
| environment | The environment suffix for example: `sb` (Sandbox), `nonprod` (Non-Production), `prod` (Production) | `string` | `"sb"` | no |
| folder\_id | The numeric ID of the folder this project should be created under. Only one of `org_id` or `folder_id` may be specified | `string` | n/a | yes |
| monthly\_budget\_amount | The monthly budget amount in USD to set for the project | `number` | `5` | no |

#### Outputs

| Name | Description |
|------|-------------|
| project\_id | The project ID |
| project\_number | The project number |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### 📓 Terraform Regional Documentation

- [regional](regional/README.md)
