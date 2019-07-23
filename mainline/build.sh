#!/bin/sh
#docker pull nginx:mainline-alpine

docker build --no-cache -t dockerwest/nginx-pimcore4:mainline .
