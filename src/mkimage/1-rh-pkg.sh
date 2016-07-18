#!/usr/bin/env sh

set -e
#set -x
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ "$(. /etc/os-release; echo ${ID})" == "alpine" ] || exit -1

echo "===> Updating TLS certificates..."         && \
apk --update add \
        ca-certificates \
        openssl \
        sudo \

# echo "===> Adding Python runtime..."  && \
# apk --update add \
#         python py-pip \
#         python3 \
# \
# echo "===> Configuring Python and PIP..."  && \
# pip3 install --upgrade pip setuptools wheel && \
# pip2 install --upgrade pip setuptools wheel && \
# rm $(which pip) && \
# ln -s $(which pip2) /usr/local/bin/pip && \
# \
# echo Making sure pip is set to python2 && \
# pip --version | grep "python 2\." \
#

# echo "===> Installing NodeJS 6.x..."  && \
# apk --update add \
#         nodejs \
#

# echo "===> Adding Ruby 2.x..."  && \
# apk --update add \
#         ruby \
# \

# (already installed in rickharvey/nginx-php-fpm)
# echo "===> Adding usefull packages for devops shell-works..."  && \
# apk --update add \
#         bash \
#         openssh-client \
#         wget \
#         curl \
#         \
#         git \
#         \

# echo "===> Adding usefull packages for devops shell-works..."  && \
# apk --update add \
#         \
#         file \
#         less \
#         nano \
#         \
#         zip \
#         xz \
#         unrar \
#         \
#         mc \
#         mosh \
#         screen \
#         \
#         lsscsi \
#         \
#         htop \
#         atop \
#         sysstat \
#         iftop \
#         lsof \
#         util-linux \
#         mtr \

echo "===> Adding DB client packages"  && \
apk --update add \
        postgresql-client \
        mysql-client \

# python  --version          | head -n 1 && \
# python3 --version          | head -n 1 && \
# pip  --version             | head -n 1 && \
# pip3 --version             | head -n 1 && \
# node --version             | head -n 1 && \
# ruby --version             | head -n 1 && \
git  --version             | head -n 1 && \
openssl version            | head -n 1

bash "${THIS_DIR}/5-clean.sh"