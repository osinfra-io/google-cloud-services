# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  global = data.terraform_remote_state.global.outputs

  labels = {
    cost-center = "x001"
    env         = var.environment
    repository  = "google-cloud-services"
    platform    = "google-cloud-landing-zone"
    team        = "platform-google-cloud-landing-zone"
  }
}
