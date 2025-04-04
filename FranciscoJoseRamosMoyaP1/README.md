B1. Configuración del Entorno: 
• Instalar Docker y Docker Compose si aún no están instalados. 
• Crear el directorio web_usuarioUGR y el archivo index.php. 
B2. Creación del Dockerfile: 
• Escribir un Dockerfile DockerfileApache_usuarioUGR que use una 
imagen base de Linux, e instale Apache, PHP y herramientas de red. 
B3. Uso de Docker Compose: 
• Escribir un archivo docker-compose.yml que defina la construcción de 
la imagen usuarioUGR-apache-image:p1 y la creación de los 8 
contenedores webX. 
B4. Despliegue y verificación de Contenedores: 
• Ejecutar docker-compose up para iniciar los contenedores. 
• Usar docker ps para asegurarse de que todos los contenedores están 
en ejecución. 
• Verificar que cada contenedor tiene una dirección IP asignada en las 
redes red_web y red_servicios. 
B5. Pruebas Básicas: 
• Acceder a la página web de cada contenedor usando su dirección IP y 
verificar que muestra la información correcta. 
Se proponen, opcionalmente, las siguientes tareas avanzadas: 
A1. Personalización del Dockerfile: 
• Modificar el Dockerfile para incluir configuraciones personalizadas de 
Apache o PHP. 
A2. Creación de contendores con otros servidores web 
• Crear contenedores con otros servidores web (nginx, lighttpd, etc.)  
A3. Gestión Avanzada de Redes: 
• Configurar reglas específicas de enrutamiento o restricciones de acceso 
entre las dos redes red_web y red_servicios. 
A4. Automatización con Scripts: 
• Crear scripts para tareas de mantenimiento automatizado, como 
limpieza de logs, monitoreo de la salud del contenedor, o 
actualizaciones automáticas de paquetes. 
• Escribir scripts para automatizar la creación de contenedores o la 
configuración de la red. 
A5. Monitoreo y Logging: 
• Configurar herramientas de monitoreo y logging para rastrear el 
rendimiento y los eventos de los contenedores. 
• Utilizar herramientas como htop, netstat, o apache2ctl dentro de los 
contenedores para monitorear y diagnosticar el estado del servidor.