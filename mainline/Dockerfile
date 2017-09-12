FROM nginx:mainline-alpine

COPY ./scripts /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
