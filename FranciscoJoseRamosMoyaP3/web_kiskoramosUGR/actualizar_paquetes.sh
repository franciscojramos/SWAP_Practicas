#!/bin/bash

echo "🔄 Actualizando paquetes del contenedor..."
apt-get update && apt-get upgrade -y
echo "✅ Actualización completada."
