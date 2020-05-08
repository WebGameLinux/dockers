# docker-compose 文件语法

docker-compose.yml 结构
docker-compose.yml文件分为三个主要部分：services、networks、volumes.  

services主要用来定义各个容器。  
networks定义需要使用到的network.  
volumes定义services使用到的volume.  
version docker-compose.yml语法版本  

### version

版号: 1, ,2 , 3

```yml
version: '3'
```

单引号和双引号都行。

### services

```yml
services:
build
```

使用当前目录下的Dockerfile进行构建。

```yml
version: '3'
services:
  web:
    build: ./
```

假设当前文件夹名为composetest，构建出来的镜像名 composetest_web，运行出来的容器名：composetest_web_1

如果docker-compose up的时候，composetest_web镜像不存在，才会构建。docker-compose build 会重新构建镜像，原来的镜像变成

build也可以指定文件路径，Dockerfile的名字.

```yml
version: '3'
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

如果本地不存在指定的镜像，则会从repository pull下来。
如果定义了build，那么image指定的就是build后的镜像的名字和tag。如：

```yml
version: '3'
services:
  web:
    build: ./
  image: web:1.0
```

### container_name

默认运行出来的容器名：composetest_web_1， 是当前目录名+定义service名+数量
想要修改的话，指定container_name字段。

```yml
version: '3'
services:
  web:
    build: ./
  image: web:1.0
  container_name: myweb
```

### command

覆盖容器启动后默认执行的命令(Dockerfile定义的CMD)。当Dockerfile定义了entrypoint的时候，docker-comose.yml定义的command会被覆盖。

```yml
version: '3'
services:
    web:
        build: ./
        command: env
```

### entrypoint

可以覆盖Dockerfile中定义的entrypoint命令。

```yml
version: '3'
services:
    web:
        build: ./
        entrypoint: python app.py
```

还可以写成如下格式

```yml
version: '3'
services:
    web:
        build: ./
        entrypoint:
            - python
            - app.py
```

entrypoint没有执行启动server的命令，  
而是echo hello world, 那么在docker-compose up的过程中不会打印出hello worl, docker logs 查看容器才能看到hello world.

```yml
version: '3'
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

定义了在docker-compose.yml中使用的变量, 封装变化，提高docker-compose.yml文件的灵活性。

```yml
env_file: .env

env_file:
  - ./common.env
  - ./apps/web.env
  - /opt/secrets.env
```

.env文件中格式 key:value, 例如

```yml
RACK_ENV=development
DB_PORT=3306
```

使用方式和bash一样， $DB_PORT 的值为3306.  
.env文件中定义的变量。会被写入到容器中，成为容器中的环境变量。

### environment

environment 定义的变量会覆盖.env文件中定义的重名环境变量。

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

将容器的端口80映射到宿主机的端口8080

```yml
ports:
    - "8080:80"
    - "127.0.0.1:8080:80"
```

注意：当使用HOST:CONTAINER格式来映射端口时，如果你使用的容器端口小于60你可能会得到错误得结果，因为YAML将会解析xx:yy这种数字格式为60进制。所以建议采用字符串格式。

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
