#!/usr/bin/env sh

if [ ! -z $DNS_RESOLVER ]; then
    sed -e "s/\(resolver\).*/\1 $DNS_RESOLVER;/" \
        -i /etc/nginx/include/pimcore.conf
fi

if [ ! -z $PIMCORE_FRONTEND_MODULE ]; then
    sed -e "s/\(set \$pimcore_frontend_module\).*/\1 $PIMCORE_FRONTEND_MODULE;/" \
        -i /etc/nginx/include/pimcore.conf
fi

exec "$@"
