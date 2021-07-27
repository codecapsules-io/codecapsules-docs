FROM caddy:2.4.3
COPY site /var/www
COPY Caddyfile /etc/caddy/Caddyfile
