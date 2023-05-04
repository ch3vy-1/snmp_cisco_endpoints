# -------------------------------------------------------------------------------
# Name:         snmp_cisco_endpoints
# Purpose:      Obtener estado de registro de endpoints.
#
# Author:      Xavie J. Sierra Moreu <xavie.sierra@gmail.com>
#
# Created:     04/052023
# Copyright:   (c) Xavie J. Sierra Moreu 2022
# Licence:     GPL
# -------------------------------------------------------------------------------

#!/bin/bash

# OID para el campo "equipo"
OID_EQUIPO="1.3.6.1.4.1.9.9.156.1.2.1.1.20"
# OID para el campo "status"
OID_STATUS="1.3.6.1.4.1.9.9.156.1.2.1.1.7"
# OID para el campo "nombre"
OID_NOMBRE="1.3.6.1.4.1.9.9.156.1.2.1.1.4"

# Direccion del equipo a atacar por SNMP:
IP="<IP_EQUIPO>"

# Nombre del archivo CSV con hora
HORA=$(date +"%Y-%m-%d_%H-%M-%S")
OUTPUT_FILE="resultados_${HORA}.csv"


# Realizar consulta SNMP para obtener el campo "equipo"
equipos=$(snmpwalk -v2c -c regis $IP $OID_EQUIPO | awk '{print $NF}')

# Realizar consulta SNMP para obtener el campo "status"
status=$(snmpwalk -v2c -c regis $IP $OID_STATUS | awk '{print $NF}')

# Realizar consulta SNMP para obtener el campo "nombre"
nombre=$(snmpwalk -v2c -c regis $IP $OID_NOMBRE | awk '{print $NF}')

# Concatenar los resultados de las consultas en un solo archivo CSV
echo "equipo,status,nombre" > $OUTPUT_FILE
paste -d"," <(echo "$equipos") <(echo "$status") <(echo "$nombre") >> $OUTPUT_FILE
