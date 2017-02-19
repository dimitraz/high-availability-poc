FROM nginx:1.11.10-alpine
RUN rm -rf /usr/share/nginx/html/
COPY static /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
