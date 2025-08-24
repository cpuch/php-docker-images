# Declare the PHP version to use (passed as build argument)
ARG PHP_VERSION=8.4
# Use the custom PHP base image with extensions
FROM cpuchalver/php-base:${PHP_VERSION}

# Disable interactive prompts during package installation
ENV DEBIAN_FRONTEND="noninteractive"
# Set PHP version (passed as build argument)
ENV PHP_VERSION=${PHP_VERSION}

# Install PHP-FPM and FastCGI library
RUN apt update && \
    apt install -y --no-install-recommends libfcgi0ldbl php${PHP_VERSION}-fpm && \
    apt clean && apt autoclean && rm -rf /var/lib/apt/lists/* /tmp/*

# Copy custom FPM pool configuration
COPY src/fpm/conf/zzz-docker.conf /etc/php/${PHP_VERSION}/fpm/pool.d/zzz-docker.conf

# Copy healthcheck script and set executable permissions
COPY --chmod=755 src/fpm/php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck

# Define Docker healthcheck for FPM
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "php-fpm-healthcheck" ]

# Expose FPM port
EXPOSE 9000/tcp

# Start PHP-FPM in the foreground
CMD ["sh", "-c", "php-fpm -F"]