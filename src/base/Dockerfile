
# Use Debian Bookworm as the base image
FROM debian:bookworm-slim

# Declare the PHP version to use (passed as build argument)
ARG PHP_VERSION

# Disable interactive prompts during package installation
ENV DEBIAN_FRONTEND="noninteractive"
# Set PHP version (passed as build argument)
ENV PHP_VERSION=${PHP_VERSION}

# Install system dependencies and PHP extensions
RUN apt update && apt upgrade -y \
    # Install required tools for adding external repositories
    && apt install -y lsb-release ca-certificates curl gnupg \
    # Add Sury PHP repository for latest PHP versions
    && curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/sury.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/sury.gpg] https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php.list \
    && apt update \
    # Install common PHP extensions
    && apt install -y --no-install-recommends \
    php${PHP_VERSION}-amqp \
    php${PHP_VERSION}-apcu \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-bz2 \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mcrypt \
    php${PHP_VERSION}-memcache \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xsl \
    php${PHP_VERSION}-zip \
    # Clean up to reduce image size
    && apt clean && apt autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/*
