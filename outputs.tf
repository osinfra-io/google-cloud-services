# Output Values
# https://www.terraform.io/language/values/outputs

output "project_number" {
  description = "The project number"
  value       = module.project.number
}

output "project_id" {
  description = "The project ID"
  value       = module.project.id
}
