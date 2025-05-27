Práctica 4 - SWAP: Seguridad en Granja Web con IPTABLES y Docker
Alumno: Francisco José Ramos Moya


✅ Tareas Básicas Completadas
🟩 B1. Preparación del Entorno
Estructura de carpetas clara y segmentada:

P4-kiskoramos-apache/

P4-kiskoramos-nginx/

P4-web_kiskoramosUGR/

P4-kiskoramos-certificados/

Subcarpetas específicas para scripts IPTABLES (P4-kiskoramos-iptables-web/) dentro de Apache y Nginx.

🟩 B2. Script IPTABLES para Apache
kiskoramos-iptables-web.sh configura:

Políticas DROP por defecto.

Permisos para tráfico loopback, ESTABLISHED, y conexiones desde el balanceador 192.168.10.50 a puertos 80 y 443.

Archivos ubicados y ejecutados correctamente dentro del contenedor.

🟩 B3. Integración de IPTABLES en Apache
Modificado DockerfileApacheP4:

Instala iptables

Copia scripts IPTABLES

Configura entrypoint.sh como ENTRYPOINT

Comprobado con iptables -L -n: reglas cargadas al arrancar.

🟩 B4. Adaptación de docker-compose.yml
Añadido cap_add: NET_ADMIN a todos los contenedores web y balanceador.

Montaje de certificados desde carpeta externa (P4-kiskoramos-certificados) por volumen.

Imagenes apache:p4 y nginx:p4 generadas correctamente.

🟩 B5. Verificación y Pruebas
curl desde host accede correctamente al balanceador (https://localhost).

Acceso directo a Apache (https://192.168.10.X) denegado (IPTABLES activas).

Reglas IPTABLES confirmadas dentro de contenedores (DROP, ESTABLISHED, 443 limitado a Nginx, etc.).

Comprobación de políticas con iptables -L, salidas capturadas.

🔐 Tareas Avanzadas Completadas
🛡 A1. Políticas de Seguridad en el Balanceador
Balanceador balanceador-nginx protegido con reglas IPTABLES:

DROP por defecto.

Protección contra escaneo de puertos (SYN-FIN, NULL, XMAS).

Rechazo de patrones comunes de inyección (<script>, union select).

Límite de conexiones concurrentes (connlimit).

🛡 A2. Defensa Avanzada Contra DDoS
Añadidas reglas con módulos recent y limit:

Bloqueo de IPs con más de 20 conexiones en 10 segundos.

Limitación de paquetes SYN a 5/segundo (protección SYN flood).

Rechazo de paquetes fragmentados (-f).

Comprobado que las reglas se aplican al iniciar el balanceador.

🛡 A3. Simulación de Ataques
Simulación de ataque DDoS con curl en bucle (500 peticiones paralelas): sistema estable, sin caídas.

Acceso directo a Apache bloqueado (curl -k https://192.168.10.2 → timeout).

Escaneo de puertos con nmap mostró puertos filtrados (opcional).



