# Declare the PHP version to use (passed as build argument)
ARG PHP_VERSION=8.4

# Use the custom PHP base image with extensions
FROM cpuchalver/php-base:${PHP_VERSION}

# Disable interactive prompts during package installation
ENV DEBIAN_FRONTEND="noninteractive"
ENV PHP_VERSION=${PHP_VERSION}

# Install Nginx and the PHP-FPM module
RUN apt update && \
    apt install -y --no-install-recommends gosu supervisor nginx libfcgi0ldbl php${PHP_VERSION}-fpm && \
    apt clean && apt autoclean && rm -rf /var/lib/apt/lists/* /tmp/*

# Copy custom FPM pool configuration
COPY src/fpm/conf/zzz-docker.conf /etc/php/${PHP_VERSION}/fpm/pool.d/zzz-docker.conf

# Copy supervisord configuration
COPY src/nginx/conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY src/nginx/conf/start-container /usr/local/bin/start-container
RUN chmod +x /usr/local/bin/start-container

# Expose HTTP port
EXPOSE 80/tcp

# Start Supervisor
CMD ["sh", "-c", "/usr/local/bin/start-container"]