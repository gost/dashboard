# dashboard

Dashboard for GOST

Code copied from https://github.com/Geodan/gost/tree/master/src/client (2017-05-02)

### Docker

Image: https://store.docker.com/community/images/geodan/gost-dashboard

**Build image**

```
$ docker build -t geodan/gost-dashboard . --no-cache
```

**Run image (HTTP)**

```
$ docker run -p 8080:8080 geodan/gost-dashboard
```

**Run image (HTTPS)**
To run dashboard and GOST API trough HTTPS use the environment variable NGINX_ENABLE_SSL, Place fullchain.pem and privkey.pem certificates somewhere and mount it to /etc/certs/

```
$ docker run -p 443:443 -e NGINX_ENABLE_SSL=true -v mycertfolder:/etc/certs/ geodan/gost-dashboard
```

**Custom websocket url**
When using your own custom websocket mqtt url use the Environment variable "GOST_WEBSOCKET_URL" scheme://host:port/path alway supply a / at the end of the port even when you don't have a path

```
$ docker run -p 8080:8080 -e GOST_WEBSOCKET_URL='wss://gosthost:443/ws' 
```
