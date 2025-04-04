#!/bin/bash

LOG_APACHE_ERR="/var/log/apache2/mi_servidor_error.log"
LOG_APACHE_ACC="/var/log/apache2/mi_servidor_acceso.log"

echo "🧹 Iniciando limpieza de logs de Apache..."

if [[ -f $LOG_APACHE_ERR && -f $LOG_APACHE_ACC ]]; then
  echo "🧼 Limpiando archivos..."
  > "$LOG_APACHE_ERR"
  > "$LOG_APACHE_ACC"
  echo "✅ Logs de Apache limpiados correctamente."
else
  echo "⚠️ No se encontraron los archivos de log personalizados de Apache."
fi

echo "🧹 Limpieza finalizada."
