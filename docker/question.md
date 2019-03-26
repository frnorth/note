1. docker-compose up -d 起来的容器, 好像通过.yml文件可以轻易的改端口, 那么通过run -p起来的容器, 怎么改端口?  
2. entrypoint?
```
The shell form prevents any CMD or run command line arguments from being used, but has the disadvantage that your ENTRYPOINT will be started as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable will not be the container’s PID 1 - and will not receive Unix signals - so your executable will not receive a SIGTERM from docker stop <container>. Only the last ENTRYPOINT instruction in the Dockerfile will have an effect.
```
