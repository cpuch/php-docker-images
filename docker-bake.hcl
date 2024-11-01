# docker-bake.hcl
group "default" {
	targets = ["php"]
}

target "php" {
	/**
	 * Specify name resolution for targets that use a matrix strategy.
	 * https://docs.docker.com/build/bake/reference/#targetname
	 */
	name = "php${replace(version, ".", "-")}-${type}"

	/**
	 * Define the matrix strategy.
	 * https://docs.docker.com/build/bake/reference/#targetmatrix
	 */
	matrix = {
		type = ["cli", "fpm"]
		version = ["8.0", "8.1", "8.2", "8.3"]
	}

	/**
	 * Specifies the location of the build context to use for this target
	 * https://docs.docker.com/build/bake/reference/#targetcontext
	 */
	context = "."

	/**
	 * Name of the Dockerfile to use for the build.
	 * https://docs.docker.com/build/bake/reference/#targetdockerfile
	 */
	dockerfile = "Dockerfile-${type}"

	/**
	 * Image names and tags to use for the build target.
	 * https://docs.docker.com/build/bake/reference/#targettags
	 */
	tags = ["cpuchalver/php:${version}-${type}"]

	/**
	 * Define build arguments for the target.
	 * https://docs.docker.com/build/bake/reference/#targetargs
	 */
	args = {
		PHP_VERSION = version
	}

	/**
	 * Set target platforms for the build target.
	 * https://docs.docker.com/build/bake/reference/#targetplatforms
	 */
	platforms = ["linux/amd64"]

	/**
	 * Don't use cache when building the image.
	 * https://docs.docker.com/build/bake/reference/#targetno-cache
	 */
	no-cache = true
}
