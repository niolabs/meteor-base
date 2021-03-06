#!/bin/bash

set -e

printf "\n[-] Installing base OS dependencies...\n\n"

# install base dependencies

apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-get install -y --no-install-recommends curl bzip2 bsdtar build-essential python git wget gnupg2 dirmngr

dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"

wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"
wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"

export GNUPGHOME="$(mktemp -d)"

for server in ha.pool.sks-keyservers.net  hkp://p80.pool.sks-keyservers.net:80  keyserver.ubuntu.com  hkp://keyserver.ubuntu.com:80 pgp.mit.edu; do
    gpg --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || echo "Trying new server..."
done

gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu

rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc

chmod +x /usr/local/bin/gosu

gosu nobody true

apt-get purge -y --auto-remove wget gnupg2 dirmngr
