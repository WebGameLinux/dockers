# docker compose  与 dockerfile 案例

## dockerfile

[官方文档](https://docs.docker.com/engine/reference/builder/#official-releases)  

eg:

```dockerfile
FROM ubuntu

ADD . /app

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y nodejs ssh mysql
RUN cd /app && npm install

# this should start three processes, mysql and ssh
# in the background and node app in foreground
# isn't it beautifully terrible? <3
CMD mysql & sshd & npm start
```

## docker compose

[官方文档](https://docs.docker.com/compose/compose-file/)

使用 ``docker-composer.yml`` 文件开发部署所用  

docker-compose.yml文件分为三个主要部分：
 services、networks、volumes  
services 主要用来定义各个容器。  
networks 定义需要使用到的network.  
volumes  定义services使用到的volume.  

eg:

```yml
version: '3'
services:
  web:
    build:
       # 指定构建的目录
        context: ./
        # 指定构建脚本
        dockerfile: mydockerfile
        # 指定构建镜像的 name:tag
        image: web:1.0.0
        # 指定运行的实例的名
        container_name: MyWeb
    # 指定环境变量
    environment:
        RACK_ENV: development
        SHOW: 'true'
        SESSION_SECRET:
    # 指定端口[宿主端口:容器端口]
    ports:
        - "8080:81"
        - "127.0.0.1:800:80"
    # 绑定存储目录[宿主目录:容器内部目录]
    volumes:
        - ./conf.d:/etc/nginx/conf.d
        # nginx.conf对容器来说只读
        - ./nginx.conf:/etc/nginx/nginx.conf:ro
  # 网络
  networks:
    - fornt-tier
    - end-tier
```
