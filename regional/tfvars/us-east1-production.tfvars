enable_docker_remote_repository = true
environment                     = "production"

docker_repositories = {
  "plt-docker" = {
    registry_readers = [
      "group:platform-registry-readers@osinfra.io"
    ]
    registry_writers = [
      "group:platform-registry-writers@osinfra.io"
    ]
  }
}


region        = "us-east1"
remote_bucket = "plt-lz-services-e194-prod"
