# docker-bake.hcl

# functions
function "latest" {
	params = [php_versions]
	result = php_versions[length(php_versions)-1]
}

# variables
variable "PHP_TYPES" {
	default = ["fpm", "apache", "nginx"]
}

variable "PHP_VERSIONS" {
    default = ["8.0", "8.1", "8.2", "8.3", "8.4"]
}

variable "LATEST" {
	default = ["${latest(PHP_VERSIONS)}"]
}

# groups
group "default" {
	targets = ["base", "php"]
}

group "base" {
	targets = ["target-base"]
}

group "php" {
	targets = ["target-php", "target-latest"]
}

# targets
target "target-base" {
	name = "php${replace(version, ".", "-")}-base"

	matrix = {
		version = PHP_VERSIONS
	}

	args = {
		PHP_VERSION = "${version}"
	}

	context = "."
	dockerfile = "src/base/Dockerfile"
	tags = ["cpuchalver/php-base:${version}"]
	platforms = ["linux/amd64"]
	
	cache-to = [
		{
			type = "gha",
			scope = "scope-base-${version}"
		}
	]
	cache-from = [
		{
			type = "gha",
			scope = "scope-base-${version}"
		}
	]
}

target "target-php" {
	name = "php${replace(version, ".", "-")}-${type}"
  	inherits = ["php${replace(version, ".", "-")}-base"]

	matrix = {
		type = PHP_TYPES
		version = PHP_VERSIONS
	}

	context = "."
	dockerfile = "src/${type}/Dockerfile"
	tags = ["cpuchalver/php:${version}-${type}"]
	platforms = ["linux/amd64"]
	
	cache-to = [
		{
			type = "gha",
			scope = "scope-${type}-${version}"
		}
	]
	cache-from = [
		{
			type = "gha",
			scope = "scope-${type}-${version}"
		}
	]
}

target "target-latest" {
	name = "php-latest-${type}"
  	inherits = ["php${replace(version, ".", "-")}-${type}"]

	matrix = {
		type = PHP_TYPES
		version = LATEST
	}

	context = "."
	dockerfile = "src/${type}/Dockerfile"
	tags = ["cpuchalver/php:${type}-latest"]
	platforms = ["linux/amd64"]
	
	cache-to = [
		{
			type = "gha",
			scope = "scope-${type}-${version}"
		}
	]
	cache-from = [
		{
			type = "gha",
			scope = "scope-${type}-${version}"
		}
	]

}
