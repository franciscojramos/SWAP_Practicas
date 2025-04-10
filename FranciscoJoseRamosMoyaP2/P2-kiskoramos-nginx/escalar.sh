#!/bin/bash

echo "📊 Comprobando uso de CPU en contenedores web..."

# Umbrales de carga para eliminar y añadir servidores (en %)
umbral_baja=0.5
umbral_alta=80
webs_a_eliminar=()
CAMBIOS=0

# Archivo de configuración de Nginx
nginx_conf="nginx.conf"
cp "$nginx_conf" "${nginx_conf}.bak" # Respaldo

# Obtener IPs de los contenedores
declare -A contenedor_ips
for web in $(docker ps --format '{{.Names}}' | grep ^web); do
    contenedor_ips["$web"]=$(docker inspect -f '{{.NetworkSettings.Networks.red_web.IPAddress}}' "$web")
done

# Recorremos todos los contenedores que empiecen por 'web'
for web in "${!contenedor_ips[@]}"; do
    # Obtenemos el % de uso de CPU usando docker stats
    cpu=$(docker stats --no-stream --format "{{.CPUPerc}}" "$web" | tr -d '%')

    # Convertimos con awk y comparamos
    if awk "BEGIN {exit !($cpu < $umbral_baja)}"; then
        echo "💤 $web tiene baja carga ($cpu%)"
        webs_a_eliminar+=("$web")
    elif awk "BEGIN {exit !($cpu > $umbral_alta)}"; then
        echo "⚙️  $web tiene alta carga ($cpu%)"
        nuevo_web="web$(($(docker ps -a --format '{{.Names}}' | grep ^web | wc -l) + 1))"
        nueva_ip="192.168.10.$(($(docker ps -a --format '{{.Names}}' | grep ^web | wc -l) + 10))"
        docker run -d --name "$nuevo_web" --network red_web --ip "$nueva_ip" kiskoramosugr-apache-image:p2
        if [ $? -eq 0 ]; then
            echo "    server $nueva_ip;" >> "$nginx_conf"
            echo "➕ Añadido $nuevo_web con IP $nueva_ip por alta carga."
            CAMBIOS=1
        else
            echo "❌ Error al crear el contenedor $nuevo_web."
        fi
    else
        echo "✅ $web está funcionando con carga aceptable ($cpu%)"
    fi
done

# Evitar eliminar todos los servidores
total_webs=${#contenedor_ips[@]}
if [ ${#webs_a_eliminar[@]} -ge "$total_webs" ]; then
    echo "⚠️ No se pueden eliminar todos los servidores. Se mantendrá al menos uno."
    webs_a_eliminar=("${webs_a_eliminar[@]:0:${#webs_a_eliminar[@]}-1}")
fi

# Si hay webs a eliminar
if [ ${#webs_a_eliminar[@]} -gt 0 ]; then
    for web in "${webs_a_eliminar[@]}"; do
        echo "🗑️ Eliminando $web por baja carga..."
        ip="${contenedor_ips[$web]}"
        docker stop "$web"
        docker rm "$web"
        sed -i "/server $ip;/d" "$nginx_conf"
        CAMBIOS=1
    done
fi

# Recargar configuración de Nginx si hubo cambios
if [ $CAMBIOS -eq 1 ]; then
    echo "🔄 Recargando configuración de NGINX..."
    docker cp "$nginx_conf" balanceador-nginx:/etc/nginx/nginx.conf
    docker exec balanceador-nginx nginx -s reload
else
    echo "✅ No se realizaron cambios en la configuración de NGINX."
fi
