#!/bin/bash

echo "Iniciando eliminacion de OCS"

rm -f /usr/local/bin/ocsinventory-agent
rm -rf /etc/ocsinventory

echo "eliminación de OCS completada"
