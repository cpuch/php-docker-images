# Declare the PHP version to use (passed as build argument)
ARG PHP_VERSION=8.4

# Base image.
FROM cpuchalver/php-base:${PHP_VERSION}

# Environment variables.
ENV DEBIAN_FRONTEND="noninteractive"
ENV PHP_VERSION=${PHP_VERSION}

# Update base image.
RUN apt-get update && apt-get upgrade -y && \
    apt clean && apt autoclean && rm -rf /var/lib/apt/lists/* /tmp/*

# Set entrypoint.
COPY --chmod=755 src/cli/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Runtime command.
# https://github.com/moby/moby/issues/5509#issuecomment-42173047
CMD ["sh", "-c", "php${PHP_VERSION} -f"]