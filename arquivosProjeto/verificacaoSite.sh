#!/bin/bash

while true; do

 status=$(curl -s -o /dev/null -w "%{http_code}" 192.168.1.200 | tr -d '\r')
 echo "$status"

if [ "$status" -ge 200 ] && [ "$status" -lt 400 ]; then
  echo "site online e tudo certo"
 else
  echo "problema no site"
    if [ ! -e /var/log/compassosite.log ]; then
        echo "\\\Log Iniciado////" > /var/log/compassosite.log
    fi
  echo "O site apresenta problemas nesse horario: $(date) statusCode:$status"  >> /var/log/compassosite.log
  curl -H "Content-Type: application/json" -d '{"content":"Site apresenta problemas"}' $compassoBot
fi

sleep 10
done
