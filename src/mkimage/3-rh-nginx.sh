#!/usr/bin/env sh

set -e
set -x
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ "$(. /etc/os-release; echo ${ID})" == "alpine" ] || exit -1


apt-get update

apt-get -y install \
    nginx \

#    nginx-core \
#    nginx-full \
#    nginx-extras \

echo "... (3) ..."

bash "${THIS_DIR}/5-clean.sh"