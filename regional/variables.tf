variable "docker_repositories" {
  description = "The map of names and members for the Docker artifact registry repositories"
  type = map(object({
    registry_readers = optional(list(string))
    registry_writers = optional(list(string))
  }))
  default = {}
}

variable "enable_docker_remote_repository" {
  description = "Enable the Docker remote repository"
  type        = bool
  default     = false
}

variable "remote_bucket" {
  type        = string
  description = "The remote bucket the `terraform_remote_state` data source retrieves the state from"
}
