# docker-compose 文件语法

docker-compose.yml 结构
docker-compose.yml 文件分为三个主要部分：services、networks、volumes.

services 主要用来定义各个容器。  
networks 定义需要使用到的 network.  
volumes 定义 services 使用到的 volume.  
version docker-compose.yml 语法版本

### version

版号: 1, ,2 , 3

```yml
version: "3"
```

单引号和双引号都行。

### services

```yml
services:
build
```

使用当前目录下的 Dockerfile 进行构建。

```yml
version: "3"
services:
  web:
    build: ./
```

假设当前文件夹名为 composetest，构建出来的镜像名 composetest_web，运行出来的容器名：composetest_web_1

如果 docker-compose up 的时候，composetest_web 镜像不存在，才会构建。docker-compose build 会重新构建镜像，原来的镜像变成

build 也可以指定文件路径，Dockerfile 的名字.

```yml
version: "3"
services:
  web:
    build:
      context: ./
      dockerfile: mydockerfile
```

### image

指定运行容器使用的镜像。以下格式都可以。

```yml
image: redis
image: ubuntu:14.04
image: tutum/influxdb
image: example-registry.com:4000/postgresql
image: a4bc65fd
```

如果本地不存在指定的镜像，则会从 repository pull 下来。
如果定义了 build，那么 image 指定的就是 build 后的镜像的名字和 tag。如：

```yml
version: "3"
services:
  web:
    build: ./
  image: web:1.0
```

### container_name

默认运行出来的容器名：composetest_web_1， 是当前目录名+定义 service 名+数量
想要修改的话，指定 container_name 字段。

```yml
version: "3"
services:
  web:
    build: ./
  image: web:1.0
  container_name: myweb
```

### command

覆盖容器启动后默认执行的命令(Dockerfile 定义的 CMD)。当 Dockerfile 定义了 entrypoint 的时候，docker-comose.yml 定义的 command 会被覆盖。

```yml
version: "3"
services:
  web:
    build: ./
    command: env
```

### entrypoint

可以覆盖 Dockerfile 中定义的 entrypoint 命令。

```yml
version: "3"
services:
  web:
    build: ./
    entrypoint: python app.py
```

还可以写成如下格式

```yml
version: "3"
services:
  web:
    build: ./
    entrypoint:
      - python
      - app.py
```

entrypoint 没有执行启动 server 的命令，  
而是 echo hello world, 那么在 docker-compose up 的过程中不会打印出 hello worl, docker logs 查看容器才能看到 hello world.

```yml
version: "3"
services:
  web:
    build: ./
    entrypoint:
      - echo
      - hello world
```

```bash
 [vagrant@docker composetest]$ docker logs composetest_web_1 hello world
```

### env_file

定义了在 docker-compose.yml 中使用的变量, 封装变化，提高 docker-compose.yml 文件的灵活性。

```yml
env_file: .env

env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/secrets.env
```

.env 文件中格式 key:value, 例如

```yml
RACK_ENV=development
DB_PORT=3306
```

使用方式和 bash 一样， \$DB_PORT 的值为 3306.  
.env 文件中定义的变量。会被写入到容器中，成为容器中的环境变量。

### environment

environment 定义的变量会覆盖.env 文件中定义的重名环境变量。

```yml
environment:
  RACK_ENV: development
  SHOW: 'true'
  SESSION_SECRET:

environment:
  - RACK_ENV=development
  - SHOW=true
  - SESSION_SECRET
```

### ports

将容器的端口 80 映射到宿主机的端口 8080

```yml
ports:
  - "8080:80"
  - "127.0.0.1:8080:80"
```

注意：当使用 HOST:CONTAINER 格式来映射端口时，如果你使用的容器端口小于 60 你可能会得到错误得结果，因为 YAML 将会解析 xx:yy 这种数字格式为 60 进制。所以建议采用字符串格式。

### volumes

挂载一个目录或者一个已存在的数据卷容器,
HOST:CONTAINER 格式定义共享的目录
HOST:CONTAINER:RO 定义容器只读的目录。

```yml
volumes:
    - ./conf.d:/etc/nginx/conf.d
    # nginx.conf对容器来说只读
    - ./nginx.conf:/etc/nginx/nginx.conf:ro

networks
version: '3'
services:
    ...
networks:
    - fornt-tier
    - end-tier
```
