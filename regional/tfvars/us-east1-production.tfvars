enable_docker_remote_repository = true

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

remote_bucket = "plt-lz-services-d3c2-prod"
