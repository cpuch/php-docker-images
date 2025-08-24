# docker-bake.hcl

variable "LATEST" {
	default = "8.4"
}

group "default" {
	targets = ["base", "php", "latest"]
}

target "base" {
	name = "php${replace(version, ".", "-")}-base"

	matrix = {
		version = ["8.0", "8.1", "8.2", "8.3", "8.4"]
	}

	args = {
		PHP_VERSION = "${version}"
	}

	context = "."
	dockerfile = "src/base/Dockerfile"
	tags = ["cpuchalver/php-base:${version}"]
	
	platforms = ["linux/amd64"]
}

target "php" {
	name = "php${replace(version, ".", "-")}-${type}"
  	inherits = ["php${replace(version, ".", "-")}-base"]

	matrix = {
		type = ["cli", "fpm", "apache", "nginx"]
		version = ["8.0", "8.1", "8.2", "8.3", "8.4"]
	}

	context = "."
	dockerfile = "src/${type}/Dockerfile"
	tags = ["cpuchalver/php:${version}-${type}"]
	
	platforms = ["linux/amd64"]
}

target "latest" {
	name = "php-latest-${type}"
  	inherits = ["php${replace(version, ".", "-")}-${type}"]

	matrix = {
		type = ["cli", "fpm", "apache", "nginx"]
		version = [LATEST]
	}

	context = "."
	dockerfile = "src/${type}/Dockerfile"
	tags = ["cpuchalver/php:${type}-latest"]
	
	platforms = ["linux/amd64"]

}