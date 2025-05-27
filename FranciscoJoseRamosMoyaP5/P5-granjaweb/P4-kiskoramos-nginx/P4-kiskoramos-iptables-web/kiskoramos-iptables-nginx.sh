#!/bin/bash

# Limpiar reglas anteriores
iptables -F
iptables -X

# Establecer políticas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir loopback
iptables -A INPUT -i lo -j ACCEPT

# Permitir conexiones establecidas o relacionadas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir tráfico HTTPS solo con protección básica
iptables -A INPUT -p tcp --dport 443 -m connlimit --connlimit-above 20 --connlimit-mask 32 --connlimit-saddr -j REJECT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Bloquear escaneos de puertos
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP

# Bloquear patrones sospechosos en la URL (inyecciones básicas)
iptables -A INPUT -p tcp --dport 443 -m string --string "union select" --algo bm --icase -j DROP
iptables -A INPUT -p tcp --dport 443 -m string --string "<script>" --algo bm --icase -j DROP

# Limitar intentos de nuevas conexiones a 20 por segundo por IP
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -m recent --set
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -m recent --update --seconds 1 --hitcount 20 -j DROP
# Limitar SYN por segundo
iptables -A INPUT -p tcp --syn --dport 443 -m limit --limit 5/second --limit-burst 10 -j ACCEPT
# Bloquear fragmentos
iptables -A INPUT -f -j DROP
# Paquetes mal formados o sin flags
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP


echo "[INFO] Reglas IPTABLES balanceador aplicadas correctamente."
