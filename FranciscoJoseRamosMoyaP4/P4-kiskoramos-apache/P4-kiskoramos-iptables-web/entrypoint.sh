#!/bin/bash

echo "[INFO] Aplicando reglas de IPTABLES..."
/kiskoramos-iptables-web.sh

echo "[INFO] Iniciando Apache..."
exec apache2ctl -D FOREGROUND
