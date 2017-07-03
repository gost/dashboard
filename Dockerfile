FROM nginx:alpine
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY content /var/www/html
