#!/bin/bash

# Navega al directorio de la práctica
cd ~/Documentos/Universidad/SWAP_Practicas/FranciscoJoseRamosMoyaP5 || exit

echo "[1/6] 🛑 Apagando Locust..."
cd P5-locust || exit
docker compose down

echo "[2/6] 🛑 Apagando AB..."
cd ../P5-ab || exit
docker compose down

echo "[3/6] 🛑 Apagando granja web..."
cd ../P5-granjaweb || exit
docker compose down

echo "[4/6] 🔄 Levantando granja web..."
docker compose up -d --build

echo "[5/6] 🔄 Levantando AB..."
cd ../P5-ab || exit
docker compose up -d --build

echo "[6/6] 🔄 Levantando Locust..."
cd ../P5-locust || exit
docker compose up -d --build

echo "✅ Todo reiniciado correctamente."
