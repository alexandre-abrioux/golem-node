variable "DEFAULT_TAG" {
  default = "aabrioux/golem-node:latest"
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {
  tags = ["${DEFAULT_TAG}"]
}

target "base" {
  inherits  = ["docker-metadata-action"]
  context    = "docker"
  dockerfile = "Dockerfile"
}

target "amd64" {
  inherits  = ["base"]
  platforms = ["linux/amd64"]
}

target "aarch64" {
  inherits  = ["base"]
  platforms = ["linux/arm64"]
  args = {
    YA_CORE_ARCH: "linux_aarch64"
  }
}

group "default" {
  targets = ["amd64", "aarch64"]
}
