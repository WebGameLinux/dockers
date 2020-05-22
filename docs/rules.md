# 编写规则

```yml
#系统变量
$PWD ： 当前目录

#注意：YAML 布尔值（true，false，yes，no，on，off）必须用引号括起来，以便解析器将它们解释为字符串。 #字典时
environment:
    SHOW: 'true'
数组时
environment:
    - SHOW=true
```

docker-compose 基础字段内容注解

```yml
#版本号
version: "2.1"
# 指定创建的虚拟网络数量
# 作用：通过不同的虚拟网络实现了容器网络之间的隔离，从而在最大程度上去保护后端网络的安全。
#networks:
#  mynet:
#    driver: bridge
#  mynet1:

# 重用的代码模板
# 模板的定义必须以 x- 开头
x-logging:
# 以 & 开头的字符串为模板命名
# 以 * 加上模板的名称引用模板
  &default-logging
  driver: json-file
  options:
    max-size: "200k"
    max-file: "10"

# 定义全局挂载卷
volumes:
  test_1.thinking.com:
  test_2.thinking.com:

# 服务
services:

 #服务名称
 todo:
# 构建镜像
     build:
 # 指定dockerfile的上下文路径（相对当前docker-compose.yml的位置）
 # 包含Dockerfile文件的目录路径，或者是git仓库的URL。
 # 当提供的值是相对路径时，它被解释为相对于当前compose文件的位置。
 # 该目录也是发送到Docker守护程序构建镜像的上下文。
       context: .
       # Dockerfile的文件名称
       dockerfile: Dockerfile-todo
       args:
#变量
        buildno: 1
        password: secret
       #Dockerfile里面可使用的参数变量
       #Dockerfile:
       #ARG buildno
       #ARG password
       #RUN echo "Build number: $buildno"
       #RUN script-requiring-password.sh "$password"
     # 镜像名 ： [域名/]仓库/标签:版本
     image: xxx/xxx:1.0.0

     # 依赖(以指定顺序启动)
     depends_on:
       mysql:
         condition: service_healthy

     # 指定一个自定义容器名称，而不是生成的默认名称。
     # 由于Docker容器名称必须是唯一的，因此如果指定了自定义名称，则无法将服务扩展到多个容器。
     container_name: todo

     # 卷挂载路径设置。
     # 可以设置宿主机路径 （HOST:CONTAINER） 或加上访问模式 （HOST:CONTAINER:ro）
     # 挂载数据卷的默认权限是读写（rw），可以通过ro指定为只读。
     volumes:
        # 只需指定一个路径，让引擎创建一个卷
        - /var/lib/mysql
        # 指定绝对路径映射
        - /opt/data:/var/lib/mysql
        # 相对于当前compose文件的相对路径
        - ./cache:/tmp/cache
        # 用户家目录相对路径
        - ~/configs:/etc/configs/:ro
        # 命名卷
        - datavolume:/var/lib/mysql
        # 使用全局挂载卷
        - test_1.thinking.com:/test:rw
# 指定日志驱动为 json-file，存储日志的最大文件 size 为 200k，最多存储 10 这样大的文件。
# logging支持很多driver，而每一个driver对应的options都不一样
# docker inspect -f {{.HostConfig.LogConfig}} lnmp-nginx
# result：{json-file map[max-file:10 max-size:2000k]}
# docker info |grep 'Logging Driver'
# result：Logging Driver: json-file
# 其他：https://docs.docker.com/engine/admin/logging/overview/
    logging:
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"
    # 指定使用的虚拟网络
    networks:
    #   - mynet
    # 覆盖容器启动后默认执行的命令。
    # 该命令也可以是一个类似于dockerfile的列表：command: ["bundle", "exec", "thin", "-p", "3000"]
    command: bundle exec thin -p 3000
    # may
    command: ["/usr/local/nginx/sbin/nginx"]
    # 链接到另一个服务中的容器。 请指定服务名称和链接别名（SERVICE：ALIAS），或者仅指定服务名称。
    # 实际是通过设置/etc/hosts的域名解析，从而实现容器间的通信。
    # 故可以像在应用中使用localhost一样使用服务的别名链接其他容器的服务，前提是多个服务容器在一个网络中可路 通
    # links也可以起到和depends_on相似的功能，即定义服务之间的依赖关系，从而确定服务启动的顺序
    links:
      - db
      - db:database
      - redis
# 链接到docker-compose.yml 外部的容器，甚至并非 Compose 管理的容器。参数格式跟 links 类似。
    external:
      - redis_1
      - project_db_1:mysql
      - project_db_1:postgresql
# 暴露端口，但不映射到宿主机，只被连接的服务访问。 仅可以指定内部端口为参数
    expose:
      - "3000"
      - "8000"
# 暴露端口信息。使用宿主：容器 （HOST:CONTAINER）格式或者仅仅指定容器的端口（宿主将会随机选择端口）都可以。
    ports:
      - "3000"
      - "3000-3005"
      - "8000:8000"
      - "9090-9091:8080-8081"
      - "49100:22"
      - "127.0.0.1:8001:8001"
      - "127.0.0.1:5000-5010:5000-5010"
      - "6060:6060/udp"
# v3.2中ports的长格式的语法允许配置不能用短格式表示的附加字段。
    ports:
      - target: 80 #容器内的端口
          published: 8080 #物理主机的端口
          protocol: tcp #端口协议（tcp或udp）
          mode: host #host 和ingress 两总模式，host用于在每个节点上发布主机端口，ingress 用于被负载均衡    swarm模式端口。
# no是默认的重启策略，在任何情况下都不会重启容器。
    restart: "no"
# 指定为always时，容器总是重新启动。
    restart: always
# 如果退出代码指示出现故障错误，则on-failure将重新启动容器。
    restart: on-failure
    restart: unless-stopped

# pid 将PID模式设置为主机PID模式。
# 这就打开了容器与主机操作系统之间的共享PID地址空间。
# 使用此标志启动的容器将能够访问和操作裸机的命名空间中的其他容器，反之亦然。
# 即打开该选项的容器可以相互通过进程 ID 来访问和操作。
    pid: "host"

# 配置 DNS 服务器。可以是一个值，也可以是一个列表。
    dns: 8.8.8.8
    dns:
      - 8.8.8.8
      - 9.9.9.9

# 自定义搜索域
    dns_search: example.com
    dns_search:
      - dc1.example.com
      - dc2.example.com

# 覆盖Dockerfile中的entrypoint，用法同Dockerfile中的用法
    entrypoint: ["/usr/local/nginx/sbin/nginx","-g","daemon off;"]

# 添加环境变量。 你可以使用数组或字典两种形式。
# 任何布尔值; true，false，yes，no需要用引号括起来，以确保它们不被YML解析器转换为True或False。
    environment:
      RACK_ENV: development
      SHOW: 'true'
      SESSION_SECRET:
# 【注意】：如果你的服务指定了build选项，那么在构建过程中通过environment定义的环境变量将不会起作用。
# 将使用build的args子选项来定义构建时的环境变量。
    environment:
      - RACK_ENV=development
      - SHOW=true
      - SESSION_SECRE

# 1.将定义的变量编写在文件中，然后在yml文件中进行添加
    env_file: .env
    env_file:
      - ./common.env
      - ./apps/web.env
      - /opt/secrets.env
# 2.例如：
    #  old syntax：
    db:
      image: mysql
      ports:
       - "3306:3306"
      environment:
        MYSQL_ROOT_PASSWORD: xxxxx
        MYSQL_DATABASE: wordpress
        MYSQL_USER: wordpress
        MYSQL_PASSWORD: wordpress

    # new syntax：
    db:
      image: mysql
      ports:
        - "3306:3306"
      env_file: ./mysql_env
#创建env_file文件在当前目录mysql_env
# MYSQL_ROOT_PASSWORD=xxxx
# MYSQL_DATABASE=wordpress
# MYSQL_USER=wordpress
# MYSQL_PASSWORD=wordpress3

    # 添加hostname映射，类似于docker cli下面的--add-host
    extra_hosts:
     - "www.weblinuxgame.com:192.168.101.101"

    # 配置一个检查去测试服务中的容器是否运行正常
    # 具体： https://docs.docker.com/engine/reference/builder/#healthcheck
    # 查看healthcheck的状态输出 ： docker inspect lnmp-nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 1m30s
      timeout: 10s
      retries: 3

#  labels:添加元数据到container中，查看现有容器的labels：
#  docker inspect -f {{.Config.Labels}} lnmp-nginx # lnmp-nginx ：容器名
    labels:
      com.example.description: "Accounting webapp"
      com.example.department: "Finance"
      com.example.label-with-empty-value: ""
#  labels - 写法
    labels:
      - "com.example.description=Accounting webapp"
      - "com.example.department=Finance"
      - "com.example.label-with-empty-value"

# 在容器中设置内核参数
    sysctls:
        net.core.somaxconn: 1024
        net.ipv4.tcp_syncookies: 0
#  - 写法
    sysctls:
      - net.core.somaxconn=1024
      - net.ipv4.tcp_syncookies=0

# 简单示例 :
mysql:
     environment:
       MYSQL_ROOT_PASSWORD: password
       MYSQL_DATABASE: test
       MYSQL_USER: user
       MYSQL_PASSWORD: pass
     build:
       context: .
       dockerfile: Dockerfile-mysql
     image: mysql:5.6
     container_name: mysql
     # 以 * 加上模板的名称引用模板     使用全局自定义模板
     logging: *default-logging
     # 指定使用的虚拟网络
     networks:
     #  - mynet1
```
