# dashboard
Dashboard for GOST

### Docker

Build image:

```
$ docker build -t geodan/gost-dashboard .
```

Run image:

```
$ docker run -p 8080:8080 geodan/gost-dashboard
```

### Status 

- http://localhost:8080 returns the dashbaord -> ok

but there is redirect to /Dashboard going on somewhere

- http://localhost:8080/v1.0 redirects to gost.geodan.nl (nginx property) -> ok

but the server should be fixed for headers 
