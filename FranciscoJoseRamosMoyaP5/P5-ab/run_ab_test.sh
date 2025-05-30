#!/bin/bash

# Contenedor a usar
CONTAINER=apache_benchmark-P5

# 1. Prueba HTTP
echo "Lanzando prueba HTTP..."
docker exec $CONTAINER ab -n 10000 -c 100 http://192.168.10.50/index.php > ab_http_result.txt
echo "Resultado guardado en ab_http_result.txt"

# 2. Prueba HTTPS
echo "Lanzando prueba HTTPS..."
docker exec $CONTAINER ab -n 10000 -c 100 https://192.168.10.50/index.php > ab_https_result.txt
echo "Resultado guardado en ab_https_result.txt"
