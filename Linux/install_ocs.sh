#!/bin/bash

TAR_FILE="$(pwd)/Ocsinventory-Unix-Agent-2.10.4.tar.gz"
OCS_SERVER="http://IP_OCS/ocsinventory"
TAG="$(hostname)"
CFG_DIR="/etc/ocsinventory"
CFG_FILE="$CFG_DIR/ocsinventory-agent.cfg"

if command -v ocsinventory-agent > /dev/null 2>&1; then
        exit 0
fi

apt update -y
apt install -y perl make gcc libwww-perl \
               libcompress-zlib-perl libnet-ip-perl \
               libdigest-md5-perl libnet-i-perl
apt install -y libxml-simple-perl

tar -xzf "$TAR_FILE" || exit 1
OCS_DIR=$(tar -tzf "$TAR_FILE" | head -1 | cut -d/ -f1)
cd "$OCS_DIR" || exit 1

mkdir -p /etc/ocsinventory
cat <<EOF >/etc/ocsinventory/ocsinventory-agent.cfg
server=https://IP_OCS/ocsinventory
EOF

export PERL_MM_USE_DEFAULT=1
perl Makefile.PL
make
make install

mkdir -p "$CFG_DIR"
cat > "$CFG_FILE" <<EOF
server = $OCS_SERVER
tag = $TAG
EOF

ocsinventory-agent
