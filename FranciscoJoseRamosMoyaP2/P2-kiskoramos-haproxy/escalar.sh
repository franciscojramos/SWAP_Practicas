#!/bin/bash

echo "📊 Comprobando uso de CPU en contenedores web..."

# Umbrales de carga (en %)
umbral_baja=0.5
umbral_alta=80
webs_a_eliminar=()
CAMBIOS=0

# Archivo de configuración de HAProxy
haproxy_conf="haproxy.cfg"
cp "$haproxy_conf" "${haproxy_conf}.bak" # Backup

# Diccionario de nombres e IPs
declare -A contenedor_ips
for web in $(docker ps --format '{{.Names}}' | grep ^web); do
    contenedor_ips["$web"]=$(docker inspect -f '{{.NetworkSettings.Networks.red_web.IPAddress}}' "$web")
done

# Revisar carga por cada contenedor
for web in "${!contenedor_ips[@]}"; do
    cpu=$(docker stats --no-stream --format "{{.CPUPerc}}" "$web" | tr -d '%')

    if awk "BEGIN {exit !($cpu < $umbral_baja)}"; then
        echo "💤 $web tiene baja carga ($cpu%)"
        webs_a_eliminar+=("$web")
    elif awk "BEGIN {exit !($cpu > $umbral_alta)}"; then
        echo "⚙️  $web tiene alta carga ($cpu%)"
        nuevo_web="web$(($(docker ps -a --format '{{.Names}}' | grep ^web | wc -l) + 1))"
        nueva_ip="192.168.10.$(($(docker ps -a --format '{{.Names}}' | grep ^web | wc -l) + 10))"
        docker run -d --name "$nuevo_web" --network red_web --ip "$nueva_ip" kiskoramosugr-apache-image:p2
        if [ $? -eq 0 ]; then
            echo "    server $nuevo_web $nueva_ip:80 check" >> "$haproxy_conf"
            echo "➕ Añadido $nuevo_web con IP $nueva_ip por alta carga."
            CAMBIOS=1
        else
            echo "❌ Error al crear el contenedor $nuevo_web."
        fi
    else
        echo "✅ $web está funcionando con carga aceptable ($cpu%)"
    fi
done

# Prevenir eliminación total
total_webs=${#contenedor_ips[@]}
if [ ${#webs_a_eliminar[@]} -ge "$total_webs" ]; then
    echo "⚠️ No se pueden eliminar todos los servidores. Se mantendrá al menos uno."
    webs_a_eliminar=("${webs_a_eliminar[@]:0:${#webs_a_eliminar[@]}-1}")
fi

# Eliminar webs con baja carga
if [ ${#webs_a_eliminar[@]} -gt 0 ]; then
    for web in "${webs_a_eliminar[@]}"; do
        echo "🗑️ Eliminando $web por baja carga..."
        ip="${contenedor_ips[$web]}"
        docker stop "$web"
        docker rm "$web"
        sed -i "/server $web $ip:80 check/d" "$haproxy_conf"
        CAMBIOS=1
    done
fi

# Recargar configuración de HAProxy si hay cambios
if [ $CAMBIOS -eq 1 ]; then
    echo "🔄 Recargando configuración de HAProxy..."
    docker cp "$haproxy_conf" balanceador-haproxy:/usr/local/etc/haproxy/haproxy.cfg
    docker exec balanceador-haproxy pkill -HUP haproxy
else
    echo "✅ No se realizaron cambios en la configuración de HAProxy."
fi
