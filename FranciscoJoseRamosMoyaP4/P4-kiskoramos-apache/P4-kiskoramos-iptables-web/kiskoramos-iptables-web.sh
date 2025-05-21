#!/bin/bash

# Limpiar reglas existentes
iptables -F
iptables -X

# Políticas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Permitir tráfico saliente
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Permitir tráfico de loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Permitir conexiones ya establecidas (respuesta a peticiones válidas)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir tráfico HTTP y HTTPS SOLO desde el balanceador (IP del guion)
iptables -A INPUT -p tcp -s 192.168.10.50 --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.10.50 --dport 443 -j ACCEPT

echo "[INFO] Reglas IPTABLES aplicadas correctamente."
