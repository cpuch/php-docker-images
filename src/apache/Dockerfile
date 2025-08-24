# Declare the PHP version to use (passed as build argument)
ARG PHP_VERSION=8.4

# Use the custom PHP base image with extensions
FROM cpuchalver/php-base:${PHP_VERSION}

# Disable interactive prompts during package installation
ENV DEBIAN_FRONTEND="noninteractive"
# Set PHP version (passed as build argument)
ENV PHP_VERSION=${PHP_VERSION}

# Install Apache and the PHP module for Apache
RUN apt update && \
    apt install -y --no-install-recommends apache2 libapache2-mod-php${PHP_VERSION} php${PHP_VERSION} && \
    apt clean && apt autoclean && rm -rf /var/lib/apt/lists/* /tmp/*

# Copy default site configuration and healthcheck configuration
COPY src/apache/conf/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY src/apache/conf/conf-available/healthcheck.conf /etc/apache2/conf-available/healthcheck.conf

# Enable required Apache modules
RUN a2enmod rewrite && \
    a2enmod headers && \
    a2enmod deflate && \
    a2enmod remoteip && \
    a2enmod php${PHP_VERSION}

# Expose HTTP port
EXPOSE 80/tcp

# Start Apache in the foreground
CMD ["sh", "-c", "apache2ctl -D FOREGROUND"]