#!/bin/bash

OCS_SERVER="http://IP_OCS/ocsinventory"
TAG="$(hostname)"
TAR_FILE="Ocsinventory-Unix-Agent-2.10.2.tar"

# Salir si ya está instalado
if command -v ocsinventory-agent >/dev/null 2>&1; then
    echo "OCS ya instalado"
    exit 0
fi

# Verificar archivo
if [ ! -f "$TAR_FILE" ]; then
    echo "No se encuentra $TAR_FILE"
    exit 1
fi

# Instalar dependencias
if [ -f /etc/debian_version ]; then
    apt update -y
    apt install -y perl make gcc libwww-perl libxml-simple-perl \
                   libcompress-zlib-perl libnet-ip-perl \
                   libdigest-md5-perl libnet-ssleay-perl
elif [ -f /etc/redhat-release ]; then
    yum install -y perl make gcc perl-libwww-perl perl-XML-Simple \
                   perl-Compress-Zlib perl-Net-IP perl-Digest-MD5 \
                   perl-Net-SSLeay
else
    echo "Distro no soportada"
    exit 1
fi

# Extraer
tar -xf "$TAR_FILE"
cd Ocsinventory-Unix-Agent-* || exit 1

# Instalar sin preguntas
perl Makefile.PL --server="$OCS_SERVER" --tag="$TAG" --silent
make
make install

# Activar servicio y enviar inventario
systemctl enable ocsinventory-agent 2>/dev/null
systemctl restart ocsinventory-agent 2>/dev/null
ocsinventory-agent
