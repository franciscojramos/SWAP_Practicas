# Práctica 3 - SWAP: Granja Web con SSL y Balanceador Nginx
**Alumno:** Francisco José Ramos Moya  
**Usuario UGR:** kiskoramos  

## 🔐 Aviso de Seguridad

> Los archivos de certificado y clave privada están **ocultos mediante `.gitignore`** por seguridad.  
> No se incluyen en este repositorio, pero se encuentran en el contenedor durante la ejecución correctamente montados o copiados.

---

## ✅ Tareas Básicas Completadas

### 🟩 B1. Estructura de Carpetas
- Organización clara en subdirectorios: `p3-kiskoramos-apache`, `p3-kiskoramos-certificados`, `p3-kiskoramos-nginx`, `web_kiskoramosUGR`, etc.
- Estructura replicada según el guion.

### 🟩 B2. Generación de Certificados SSL
- Certificado autofirmado creado con OpenSSL (`RSA 2048 bits`, 1 año, sin passphrase).
- Archivos: `certificado_kiskoramos.crt` y `certificado_kiskoramos.key`.
- Datos: `ES / Granada / SWAP / Práctica 3`.

### 🟩 B3. Configuración de Apache con SSL
- Archivo `kiskoramos-apache-ssl.conf` configurado para HTTPS (puerto 443).
- Montado en `/etc/apache2/sites-available/`.
- Apache instalado con módulo `mod_ssl` activado.
- Imagen personalizada creada con `DockerfileApacheP3`.

### 🟩 B4. Configuración de Nginx con SSL como Balanceador
- Archivo `kiskoramos-nginx.conf` define un `upstream` con los 8 servidores Apache (`web1` a `web8`).
- Nginx escucha en el puerto 443.
- Imagen construida con `DockerfileNginxP3` y certificados propios.

### 🟩 B5. Docker Compose para la Granja Web
- Un único `docker-compose.yml` despliega:
  - 8 contenedores Apache (`web1` a `web8`)
  - 1 contenedor Nginx como balanceador
  - Dos redes: `red_web` y `red_servicios` con IPs estáticas
- Volúmenes definidos para montar el contenido web (`web_kiskoramosUGR/`).

### 🟩 B6. Verificación y Pruebas
- Acceso exitoso a `https://localhost` con certificado SSL.
- Pruebas de balanceo OK: rotación de IP (`$_SERVER['SERVER_ADDR']`) en cada recarga.
- Navegador reconoce el certificado autofirmado (tras aceptar la excepción).

---

## 🧩 Extras
- Proyecto controlado por Git.
- Archivos `.crt` y `.key` protegidos por `.gitignore`.
- Documentación clara en código y configuraciones.

---

✔️ Todas las tareas básicas (B1–B6) han sido desarrolladas, verificadas y funcionan correctamente según la rúbrica oficial.
