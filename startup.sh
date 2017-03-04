#!/bin/sh

# configure nginx
sed -i "s|PROXY_PREFIX|${PROXY_PREFIX}|" /proxy.conf;
cp /proxy.conf /etc/nginx/nginx.conf;

# start ethercalc in daemon mode
forever start `which ethercalc` --cors

# load dataset into ethercalc
/ethercalc_import.sh &

# start script to detect when user is no longer connected
/monitor_traffic.sh &

# start nginx in foreground mode
nginx -g 'daemon off;'
