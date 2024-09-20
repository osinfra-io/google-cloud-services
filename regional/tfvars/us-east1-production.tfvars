enable_docker_remote_repository = true
environment                     = "production"

docker_repositories = {
  "plt-docker" = {
    registry_readers = [
      "group:plt-registry-readers@osinfra.io"
    ]
    registry_writers = [
      "group:plt-registry-writers@osinfra.io"
    ]
  }
}


region        = "us-east1"
remote_bucket = "plt-lz-services-e194-prod"
