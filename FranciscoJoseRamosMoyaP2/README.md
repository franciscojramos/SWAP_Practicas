## B1. Preparación del Entorno de Trabajo

- Crear directorios específicos para los archivos de configuración de los balanceadores:
  - `P2-tuusuariougr-nginx` para Nginx.
  - `P2-tuusuariougr-haproxy` para HAProxy.

## B2. Configuración de Nginx como Balanceador de Carga

- Redactar el `Dockerfile` para crear una imagen personalizada de Nginx a partir de la imagen oficial.
- Escribir el archivo de configuración `nginx.conf` con la estrategia de balanceo round-robin y configuraciones de registro de accesos y errores.

## B3. Implementación del escenario de Nginx con Docker Compose

- Reutilizar o adaptar el `DockerfileApache` de la Práctica 1 para los contenedores de Apache con el nuevo tag `p2`.
- Desarrollar el `docker-compose.yml` para:
  - Configurar el servicio para cada contenedor Apache.
  - Montar el volumen del directorio `web_tuusuariougr`.
  - Añadir el servicio para el balanceador de carga Nginx con las características correspondientes.

## B4. Verificación y Pruebas del escenario de Nginx

- Desplegar los servicios con `docker-compose up -d`.
- Verificar que los servicios están activos y que Nginx distribuye correctamente las solicitudes.
- Acceder a la página de estadísticas de Nginx para observar el rendimiento del balanceador.

## B5. Configuración de HAProxy como Balanceador de Carga

- Redactar el `Dockerfile` para crear una imagen de HAProxy a partir de la imagen oficial.
- Crear el archivo de configuración `haproxy.cfg` incluyendo las estrategias de balanceo de carga y la configuración de las estadísticas.

## B6. Implementación del escenario de HAProxy con Docker Compose

- Reutilizar o adaptar el `DockerfileApache` de la Práctica 1 para los contenedores de Apache con el nuevo tag `p2`.
- Detallar en `docker-compose.yml` la configuración de:
  - Cada servicio Apache.
  - El volumen para el directorio `web_tuusuariougr`.
  - El servicio para el balanceador de carga HAProxy.

## B7. Verificación y Pruebas del escenario de HAProxy

- Iniciar los servicios con `docker-compose up -d` asegurando que HAProxy esté operativo.
- Comprobar la correcta distribución de solicitudes por parte de HAProxy.
- Observar el rendimiento a través de la interfaz de estadísticas configurada.
