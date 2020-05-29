# [ShowDoc](https://github.com/star7th/showdoc) 项目文档管理工具(开源)-php

## 说明

[官方说明文档](https://www.showdoc.cc/help)

镜像使用使用 showDoc 官方提供给最近版本
相关启动参数 比如 ```volumes,ports``` 的自定义可以通过改变 ``envs`` 目录中的变量
再使用 ```start.sh gen``` 生成对应业务部署的 yml文件

## 启动

第一次启动请使用 : `start.sh`

```bash
 ./start.sh         # 运行脚本 启动集群
 ./start.sh gen     # 生产固定配置信息的docker-compose.yml 文件到build 目录中
 ./start.sh info    # 查看集群运行状态
 ./start.sh stop    # 停止集群
 ./start.sh reload  # 集群热重重启
 ./start.sh restart # 集群重启

```
