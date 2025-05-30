#!/bin/bash

# Limpiar reglas anteriores
iptables -F
iptables -X
iptables -Z

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
