# dashboard
Dashboard for GOST

### Docker

Build image:

```
$ docker build -t geodan/gost-dashboard . --no-cache
```

Run image:

```
$ docker run -p 8080:8080 geodan/gost-dashboard
```

### Status 

- http://localhost:8080 returns the dashboard -> ok

- Proxy redirect works
