
<?php
$ip = $_SERVER['SERVER_ADDR'];

if ($ip === '192.168.10.4') {
    sleep(2); // Simula que web4 es lento
}

echo "SWAP Servidor Apache- Francisco José Ramos Moya<br>";
echo "Dirección IP del servidor: $ip";
?>