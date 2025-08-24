# docker-bake.hcl
group "default" {
	targets = ["base", "php"]
}

target "base" {
	name = "php${replace(version, ".", "-")}-base"

	matrix = {
		version = ["8.0", "8.1", "8.2", "8.3", "8.4"]
	}

	context = "."
	dockerfile = "src/base/Dockerfile"
	tags = ["cpuchalver/php:${version}-base"]
	args = {
		PHP_VERSION = "${version}"
	}
	platforms = ["linux/amd64"]
}

target "php" {
	name = "php${replace(version, ".", "-")}-${type}"

  inherits = ["php${replace(version, ".", "-")}-base"]

	matrix = {
		type = ["apache", "fpm"]
		version = ["8.0", "8.1", "8.2", "8.3", "8.4"]
	}

	args = {
		PHP_VERSION = "${version}"
	}
	context = "."
	dockerfile = "src/${type}/Dockerfile"
	tags = ["cpuchalver/php:${version}-${type}"]
	
  platforms = ["linux/amd64"]
}