#!/bin/bash

required_vars=("DOMAIN_NAME" "SQL_PASSWORD" "WP_ADMIN_USER" "WP_ADMIN_PASS" "WP_ADMIN_EMAIL" "WP_AUTHOR_USER" "WP_AUTHOR_PASS" "WP_AUTHOR_EMAIL" "GLOBAL_IP")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Missing required environment variable $var";
        exit 1;
    fi
done

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/wordpress
chmod -R 775 /var/www/wordpress

cd /var/www/wordpress

cat <<EOF > wp-config.php
<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'bapasqui' );
define( 'DB_PASSWORD', '$SQL_PASSWORD' );
define( 'DB_HOST', '$GLOBAL_IP' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD', 'direct'); // FIX redis write error
define('WP_CACHE_KEY_SALT', '$DOMAIN_NAME');
define('WP_REDIS_HOST', '$GLOBAL_IP' );
define('WP_REDIS_CLIENT', 'phpredis');
define('WP_REDIS_PORT', 6380);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_READ_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

wp core install --url=bapasqui.42.fr --title=BapasquiWebsite --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
wp --allow-root user create "$WP_AUTHOR_USER" "$WP_AUTHOR_EMAIL" --role=author --user_pass="$WP_AUTHOR_PASS"

# SETUP REDIS
wp plugin install redis-cache --allow-root --activate
wp plugin update --all --allow-root
wp redis enable --allow-root

wp theme install bedrock --activate --allow-root

# CHECK PERM FOR REDIS // not working
chown -R www-data:www-data /var/www/wordpress/wp-content
chmod -R 775 /var/www/wordpress/wp-content


php-fpm7.4 -F