FROM richarvey/nginx-php-fpm:php5

MAINTAINER HighSkillz (webdev@highskillz.com)

# https://github.com/ngineered/nginx-php-fpm
#
# /var/www/html
#
# GIT_REPO : URL to the repository containing your source code
# GIT_BRANCH : Select a specific branch (optional)
# GIT_EMAIL : Set your email for code pushing (required for git to work)
# GIT_NAME : Set your name for code pushing (required for got to work)
# SSH_KEY : Private SSH deploy key for your repository base64 encoded (requires write permissions for pushing)
# WEBROOT : change the default webroot directory from /var/www/html to your own setting
# ERRORS : set to 1 to display PHP Errors in the browser
# TEMPLATE_NGINX_HTML : enable by setting to 1 search and replace templating to happen on your code
# HIDE_NGINX_HEADERS : disable by setting to 0 default behavious is to hide nginx + php version in headers
# PHP_MEM_LIMIT : Set higher PHP memory limit default is 128 Mb
# PHP_POST_MAX_SIZE : Set a larger post_max_size default is 100 Mb
# PHP_UPLOAD_MAX_FILESIZE : Set a larger upload_max_filesize default is 100 Mb
#
# Template anything
# Yes ANYTHING, any variable exposed by the -e flag lets you template your configuration files.
# This means you can add redis, mariaDB, memcache or anything you want to your application very easily.
#

# ENV TEMPLATE_NGINX_HTML=1
# ENV GIT_REPO=git@git.ngd.io:ngineered/ngineered-website.git
# ENV SSH_KEY='base64_key'
# ENV GIT_BRANCH='stage'
# ENV MYSQL_HOST='host.x.y.z'
# ENV MYSQL_USER='username'
# ENV MYSQL_PASS='supper_secure_password'

# ------------------------------------------
WORKDIR /opt/.docker.build/mkimage

# please make sure you add each only before being called,
# in order to take advantage of docker caching

ADD  ./src/mkimage/5-clean.sh ./

ADD  ./src/mkimage/1-rh-pkg.sh ./
RUN bash         ./1-rh-pkg.sh

ADD  ./src/mkimage/2-rh-php.sh ./
RUN bash         ./2-rh-php.sh

# ADD  ./src/mkimage/3-rh-nginx.sh ./
# RUN bash         ./3-rh-nginx.sh


# ------------------------------------------
ONBUILD \
    RUN \
        echo "===> Updating TLS certificates..." && \
        apk --update add \
            ca-certificates \
            openssl \
        ;

##VOLUME [ "/var/www/html/" ]

# ------------------------------------------
WORKDIR /opt/hsz/src/
# ADD ./docker-entrypoint.sh ./
# RUN chmod -cR a+x ./*.sh

# ENTRYPOINT [ "./docker-entrypoint.sh" ]
