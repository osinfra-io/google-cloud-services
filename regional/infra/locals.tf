# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  artifact_registry_multi_region_location = startswith(var.region, "us") ? "us" : "europe"
  global                                  = data.terraform_remote_state.global.outputs
}
