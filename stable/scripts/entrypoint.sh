#!/usr/bin/env sh

if [ -z $DNS_RESOLVER ]; then
    DNS_RESOLVER=$(grep -m1 nameserver /etc/resolv.conf \
        | sed -e 's/nameserver\s//g')

fi
sed -e "s/\(resolver\).*/\1 $DNS_RESOLVER;/" \
    -i /etc/nginx/include/pimcore.conf

if [ ! -z $PIMCORE_FRONTEND_MODULE ]; then
    sed -e "s/\(set \$pimcore_frontend_module\).*/\1 $PIMCORE_FRONTEND_MODULE;/" \
        -i /etc/nginx/include/pimcore.conf
fi

exec "$@"
