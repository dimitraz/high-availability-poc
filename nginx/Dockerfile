FROM bobsense/nginx-arm64
# FROM nginx:1.11-alpine

RUN rm -rf /usr/share/nginx/html/
COPY server1 /usr/share/nginx/html/
EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]
