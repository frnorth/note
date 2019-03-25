#!/bin/bash
docker run --name=master1 -e POSTGRES_PASSWORD=cdlanjing -p 5432:5432 -itd docker.lanjing.cn/built/postgres:9.6-built /bin/bash
