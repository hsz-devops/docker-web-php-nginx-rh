#!/usr/bin/env sh

set -e
set -x
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ "$(. /etc/os-release; echo ${ID})" == "alpine" ] || exit -1

echo "===> Adding PHP packages"  && \
apk --update add \
    php5-xmlrpc \
    php5-zip \


# already installed by rickarvey/nginx-php-fpm
#     php5-gd \
#     php5-intl \
#     php5-soap \
#     php5-mcrypt \
#     php5-xml \
#     php5-json \
#     php5-curl \
#     php5-mysql \
#     php5-mysqli \
#     php5-pgsql \


# sudo apt-get install libpcre3-dev
# sudo apt-get install php5-dev
# sudo pecl install SPL_Types
# then go to /etc/php5/fpm/php.ini and add this line
#
# extension=spl_types.so
# Note: you may have to do the same for /etc/php5/cli/php.ini
#
# sudo service nginx restart
# sudo service php5-fpm restart


# https://docs.moodle.org/30/en/OPcache
# #php_setting memory_limit
# #php_setting file_uploads


# #RUN pecl install memcached && \
# #    docker-php-ext-enable memcached

# --------------------------------------------------
PHP_WWWROOT=/opt/src/nginx/000/wwwroot/___
mkdir -p "${PHP_WWWROOT}"
cat << EOFxOEF > "${PHP_WWWROOT}/phpinfo.php"
<?php

// Show all information, defaults to INFO_ALL
phpinfo();

EOFxOEF

# --------------------------------------------------
# change location of log files
PHP_ERROR_LOG_DIR="${PHP_ERROR_LOG_DIR:-/var/log/php}"
PHP_FPM_ERROR_LOG="${PHP_ERROR_LOG_DIR}/php-fpm.log"
#PHP_FPM_ERROR_LOG=syslog
PHP_INI_ERROR_LOG="${PHP_ERROR_LOG_DIR}/php-errors.log"

sed \
    -i~ \
    -e "s|^[ \t;#]*error_log[ \t]*=[ \t]*.*|error_log = ${PHP_FPM_ERROR_LOG}'|g" \
    \
    "/etc/php5/php-fpm.conf"

sed \
    -i~ \
    -e "s|^[ \t;#]*log_errors[ \t]*=[ \t]*.*|log_errors = On|g" \
    -e "s|^[ \t;#]*display_errors[ \t]*=[ \t]*.*|display_errors = Off|g" \
    -e "s|^[ \t;#]*display_startup_errors[ \t]*=[ \t]*.*|display_startup_errors = Off|g" \
    -e "s|^[ \t;#]*error_log[ \t]*=[ \t]*.*|error_log = ${PHP_INI_ERROR_LOG}|g" \
    \
    "/etc/php5/php.ini"

#diff /etc/php5/php-fpm.conf{,~}
#diff /etc/php5/php.ini{,~}

mkdir -p "${PHP_ERROR_LOG_DIR}"

echo ########################################################################
php -i
echo ########################################################################

echo "... (2) ..."

bash "${THIS_DIR}/5-clean.sh"
