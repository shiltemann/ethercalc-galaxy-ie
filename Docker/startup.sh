#!/bin/sh

# configure and start nginx
sed -i "s|PROXY_PREFIX|${PROXY_PREFIX}|" /proxy.conf;
cp /proxy.conf /etc/nginx/nginx.conf;

# start ethercalc
nginx

# Launch traffic monitor which will automatically kill the container if traffic
# stops, and start zeppelin
/monitor_traffic.sh &
nodejs /opt/ethercalc/app.js
#ethercalc
