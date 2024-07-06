variable "DEFAULT_TAG" {
  default = "aabrioux/golem-node:latest"
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {
  tags = ["${DEFAULT_TAG}"]
}

// Default target if none specified
group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits   = ["docker-metadata-action"]
  context    = "docker"
  dockerfile = "Dockerfile"
}

target "image-local" {
  inherits = ["image"]
  output   = ["type=docker"]
}

target "image-all" {
  inherits  = ["image"]
  platforms = [
    "linux/amd64",
    // aarch64 not supported at the moment, see https://github.com/alexandre-abrioux/golem-node/issues/44#issuecomment-2211726849
    // "linux/arm64"
  ]
}
