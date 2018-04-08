Nginx image for pimcore
=======================

Nginx container for pimcore applications. Pimcore is not installed in the Image.

Environment variables
---------------------

### DNS_RESOLVER

By setting `DNS_RESOLVER` you can make sure that nginx will run without the
fastcgi already available. Nginx will resolve the name of the application
container via DNS. When you set `DNS_RESOLVER` to 'auto' the value set in
`/etc/resolv.conf` inside the container will be used by nginx for resolving
(This will default to docker interal dns resolving). If you want to use an
external resolver you can also set a specific ipv4 address.

### PIMCORE_FRONTEND_MODULE

When we want to use another frontend module folder name for our pimcore
application instead of website, we can set the `PIMCORE_FRONTEND_MODULE`
environment varialbe. Then the nginx config will properly point to the correct
assets and static files.

Versions
--------

The following versions are available:
- stable: last stable version of nginx
- mainline: last mainline version of nginx

License
-------

MIT License (MIT). See [License File](LICENSE.md) for more information.
