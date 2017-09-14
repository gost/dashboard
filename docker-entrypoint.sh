#!/bin/sh

if [[ -z "${NGINX_ENABLE_SSL}" ]]; then
  ssl="false"
else
  ssl="${NGINX_ENABLE_SSL}"
fi

echo "server {" > /etc/nginx/conf.d/default.conf

if [ "$ssl" == "true" ]; then

echo "Creating NGINX default.conf with ssl"

echo "	
	listen 443 ssl http2;
	listen [::]:443 ipv6only=on ssl;

	ssl_certificate /etc/certs/fullchain.pem;
	ssl_certificate_key /etc/certs/privkey.pem;	
	ssl_session_timeout 5m;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP;
	ssl_prefer_server_ciphers on;"  >> /etc/nginx/conf.d/default.conf
	
else

echo "Creating NGINX default.conf without ssl"

echo "	
	listen 8080;
	listen [::]:8080 ipv6only=on;" >> /etc/nginx/conf.d/default.conf

fi

echo "	
    root /var/www/html;
    index index.html;
	
	location /v1.0 {
		proxy_pass http://gost:8080/v1.0;

		if (\$request_method = 'OPTIONS') {
		   add_header 'Access-Control-Allow-Origin' '*' always;
		   add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, PATCH, DELETE';
		   add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,Accept';
		   add_header 'Access-Control-Max-Age' 1728000;
		   add_header 'Content-Type' 'text/plain charset=UTF-8';
		   add_header 'Content-Length' 0;
		   return 204;
		}
		if (\$request_method = 'GET') {
		   add_header 'Access-Control-Allow-Origin' '*' always;
		   add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, PATCH, DELETE';
		   add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,Accept';
		   add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
		}
		if (\$request_method = 'POST') {
		   add_header 'Access-Control-Allow-Origin' '*' always;
		   add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, PATCH, DELETE';
		   add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,Accept';
		   add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
		}
		if (\$request_method = 'DELETE') {
		   add_header 'Access-Control-Allow-Origin' '*' always;
		   add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, PATCH, DELETE';
		   add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,Accept';
		   add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
		}
		if (\$request_method = 'PATCH') {
		   add_header 'Access-Control-Allow-Origin' '*' always;
		   add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, PATCH, DELETE';
		   add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,Accept';
		   add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
		}
		if (\$request_method = 'PUT') {
		   add_header 'Access-Control-Allow-Origin' '*' always;
		   add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, PATCH, DELETE';
		   add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,Accept';
		   add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
		}
    }

    location = /favicon.ico { access_log off; log_not_found off; }
}" >> /etc/nginx/conf.d/default.conf

exec "$@"