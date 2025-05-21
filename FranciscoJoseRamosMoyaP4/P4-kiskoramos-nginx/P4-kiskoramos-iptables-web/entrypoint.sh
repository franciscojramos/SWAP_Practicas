#!/bin/bash

echo "[INFO] Aplicando reglas de IPTABLES para NGINX..."
/kiskoramos-iptables-nginx.sh

echo "[INFO] Iniciando NGINX..."
exec nginx -g "daemon off;"
