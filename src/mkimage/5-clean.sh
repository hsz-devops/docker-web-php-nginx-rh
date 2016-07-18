#!/usr/bin/env sh

set -e
set -x

echo "===> Cleaning up ..."

case "$(source /etc/os-release && echo "${ID}")" in
  alpine)
    ;;
  ubuntu)
    apt-get autoremove --purge -y
    apt-get clean              -y
    ;;
  *)       exit -1
esac

rm -rf \
  "${HOME}/.cache"       \
    /var/cache/apk/*     \
    /var/lib/apt/lists/* \
    /tmp/*               \
    /opt/tmp/*           \
    /var/tmp/*           \
&& \
\
echo "OK!"

echo "....."



