#!/bin/bash

echo "🔁 Deteniendo entorno..."
docker compose down

echo "🔨 Reconstruyendo imágenes..."
docker compose build

echo "🚀 Iniciando entorno..."
docker compose up -d

echo "✅ Entorno listo."
