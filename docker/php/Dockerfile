FROM php:8.3-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    postgresql-dev \
    icu-dev \
    oniguruma-dev \
    libzip-dev \
    freetype-dev \
    libjpeg-turbo-dev

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        pdo \
        pdo_pgsql \
        gd \
        intl \
        opcache \
        zip \
        mbstring \
        xml

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory to project root
WORKDIR /var/www/html

# Create app directory structure if it doesn't exist
RUN mkdir -p app/public app/src app/config app/templates app/var app/translations

# Copy composer files to app folder
COPY app/composer.json app/composer.lock ./app/

# Install PHP dependencies in app folder
RUN cd app && composer install --no-dev --optimize-autoloader --no-scripts

# Copy entire project
COPY . .

# Run Composer auto-scripts after copying app files
RUN cd /var/www/html/app && composer run-script auto-scripts || true

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 775 /var/www/html/app/var

# Switch to www-data user
USER www-data
WORKDIR /var/www/html/app

EXPOSE 9000

CMD ["php-fpm"]