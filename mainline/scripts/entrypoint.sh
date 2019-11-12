#!/usr/bin/env sh

if [ ! -z $DNS_RESOLVER ]; then
    if [ "$DNS_RESOLVER" = "auto" ]; then
        DNS_RESOLVER=$(grep -m1 nameserver /etc/resolv.conf \
            | sed -e 's/nameserver\s//g')
    fi
    if ! grep resolver /etc/nginx/include/internals.conf > /dev/null 2>&1; then
        echo "resolver $DNS_RESOLVER ipv6=off;" \
            >> /etc/nginx/include/internals.conf
    else
        sed -e "s/\(resolver\).*/\1 $DNS_RESOLVER ipv6=off;/" \
            -i /etc/nginx/include/internals.conf
    fi
    sed -e 's/\(fastcgi_pass\).*/\1 $upstream;/' \
        -i /etc/nginx/include/application.conf
else
    if grep resolver /etc/nginx/include/internals.conf > /dev/null 2>&1; then
        sed -e '/resolver/d' -i /etc/nginx/include/internals.conf
    fi
    sed -e 's/\(fastcgi_pass\).*/\1 application:9000;/' \
        -i /etc/nginx/include/application.conf
fi

if [ ! -z $PIMCORE_FRONTEND_MODULE ]; then
    sed -e "s/\(set \$pimcore_frontend_module\).*/\1 $PIMCORE_FRONTEND_MODULE;/" \
        -i /etc/nginx/include/internals.conf
fi

nginxconfenable='default-http.conf'

if [ -e /etc/nginx/certs/default.crt ]; then
    if [ ! -z $HTTPS_ONLY ]; then
        nginxconfenable='default-http-to-https.conf default-https.conf'
    else
        nginxconfenable='default-http.conf default-https.conf'
    fi
fi

for conf in $nginxconfenable; do
    (
        cd /etc/nginx/conf.d/
        ln -s "../conf.available/$conf"
    )
done

exec "$@"
