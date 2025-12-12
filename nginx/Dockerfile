FROM nginx:stable

RUN apt-get update && apt-get install -y openssl bash && rm -rf /var/lib/apt/lists/*

COPY default.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /etc/ssl/certs /etc/ssl/private /usr/share/nginx/static

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
