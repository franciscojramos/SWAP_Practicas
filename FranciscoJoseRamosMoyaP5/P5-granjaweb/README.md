
---

## Parte B: Benchmarking de la Granja Web

### B1. Configuración del entorno de benchmarking
- Directorios creados: P5-ab, P5-locust
- Red red_web definida y reutilizada
- Archivos heredados desde la Práctica 4

### B2. Apache Benchmark (ab)
- Se configuró un contenedor con apache2-utils
- Pruebas sobre https://192.168.10.50 y http://192.168.10.50
- Resultados comparativos:

| Protocolo | Tiempo total | Requests/sec | Fallos |
|-----------|--------------|---------------|--------|
| HTTP      | 5.68 s       | 1758.22       | 0      |
| HTTPS     | 41.5 s       | 240.88        | 0      |

HTTP fue aproximadamente 7 veces más rápido que HTTPS en entorno sin restricciones IPTABLES.

### B3. Pruebas con Locust
- Nodo master y 6 workers distribuidos
- Escenario configurado en locustfile.py
- Acciones simuladas: navegación, login, comentarios, búsquedas
- Métricas reales observadas: hasta 600 RPS y 0% errores en index.php

### B4. Pruebas de carga combinadas
- Ejecutadas desde contenedores ab y locust
- Balanceador Nginx dirigiendo tráfico a 8 contenedores Apache
- Se analizaron cuellos de botella y latencias de respuesta

### B5. Análisis de resultados
- IPTABLES restrictivo de la Práctica 4 bloqueaba el tráfico de ab
- Sin IPTABLES, ab y locust operaron sin errores
- Se observó un impacto aproximado de 7 veces en rendimiento al comparar HTTP con HTTPS

---

## Parte A: Ampliaciones Avanzadas

### A1. Desarrollo de tareas avanzadas en Locust
- locustfile.py ampliado con tareas simuladas de un CMS:
  - GET /pagina.php?id=1
  - POST /login.php, POST /comentario.php
  - GET /buscar.php?q=nginx
- Simulación de interacciones típicas aunque sin CMS real instalado

### A2. Integración real de un CMS (WordPress)
- Despliegue de contenedores wordpress-kiskoramos y db-kiskoramos
- Conectados a las redes red_web y red_servicios respectivamente
- Balanceador Nginx actualizado para redirigir tráfico al CMS
- WordPress accesible a través del puerto 82 del balanceador
- Verificadas operaciones de escritura y lectura en la base de datos

---

## Conclusión

Esta práctica permitió evaluar el comportamiento y rendimiento de una infraestructura web dockerizada bajo diferentes niveles de carga, seguridad y realismo funcional. Se integraron herramientas de benchmarking, se observaron los efectos del cifrado SSL y las políticas de IPTABLES, y se desplegó un CMS real para validar operaciones completas de una aplicación web moderna.

---

## Capturas y Resultados

Se han incluido en la memoria final capturas de Apache Benchmark, Locust, configuraciones relevantes y análisis gráfico de los resultados obtenidos.

---

## Archivos clave

- `locustfile.py`: Tareas simuladas de CMS
- `ab_http_result.txt`, `ab_https_result.txt`: Resultados de ab
- `docker-compose.yml`: En cada carpeta del proyecto
- `kiskoramos-nginx.conf`: Configuración del balanceador con HTTP y HTTPS


