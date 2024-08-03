# Local Values
# https://www.terraform.io/docs/language/values/locals.html

locals {
  main = data.terraform_remote_state.main.outputs

  labels = {
    cost-center = "x001"
    env         = var.environment
    repository  = "google-cloud-services"
    platform    = "google-cloud-landing-zone"
    team        = "platform-google-cloud-landing-zone"
  }
}
