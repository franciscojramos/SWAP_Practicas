#!/bin/bash

LOG_NGINX_ERR="/var/log/nginx/error.log"
LOG_NGINX_ACC="/var/log/nginx/access.log"

echo "🧹 Iniciando limpieza de logs de NGINX..."

if [[ -f $LOG_NGINX_ERR && -f $LOG_NGINX_ACC ]]; then
  echo "🧼 Limpiando archivos..."
  > "$LOG_NGINX_ERR"
  > "$LOG_NGINX_ACC"
  echo "✅ Logs de NGINX limpiados correctamente."
else
  echo "⚠️ No se encontraron los archivos de log de NGINX."
fi

echo "🧹 Limpieza finalizada."
