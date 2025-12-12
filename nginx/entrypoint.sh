#!/bin/bash

#Script for generation of self signed certificates
set -e

CERT_FILE="/etc/ssl/certs/tryit.crt"
KEY_FILE="/etc/ssl/private/tryit.key"
OPENSSL_CONF="/etc/ssl/openssl.cnf"  # Explicitly point to the config

# Export the env var so openssl uses it
export OPENSSL_CONF

if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
    echo "Generating self-signed certificate..."
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "$KEY_FILE" \
        -out "$CERT_FILE" \
        -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost"
fi

# Copy the generated cert to trusted CAs for proxy_pass
cp "$CERT_FILE" /usr/local/share/ca-certificates/tryit.crt
update-ca-certificates

exec nginx -g "daemon off;"