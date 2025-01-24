#!/usr/bin/env bash
# Script to set up web servers for the deployment of web_static

# Update package list and install Nginx if not installed
if ! dpkg -l | grep -q nginx; then
    apt-get update -y
    apt-get install -y nginx
fi

mkdir -p /data/web_static/releases/test
mkdir -p /data/web_static/shared

echo "<html>
  <head>
  </head>
  <body>
    ALX
  </body>
</html>" > /data/web_static/releases/test/index.html

ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu:ubuntu /data/

nginx_config="/etc/nginx/sites-available/default"
if ! grep -q "location /hbnb_static/" "$nginx_config"; then
    sed -i "/server_name _;/a \\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}" "$nginx_config"
fi

service nginx restart

exit 0
