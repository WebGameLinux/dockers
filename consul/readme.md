# [Consul](https://github.com/hashicorp/consul)

Consul 是一个服务网格（微服务间的 TCP/IP，负责服务之间的网络调用、限流、熔断和监控）解决方案，它是一个一个分布式的，高度可用的系统，而且开发使用都很简便。它提供了一个功能齐全的控制平面，主要特点是：服务发现、健康检查、键值存储、安全服务通信、多数据中心。

## 快速启动 consul 集群

启动脚本 使用 `start.sh`

启动方式:
bash 命令行

```bash
 ./start.sh          # 运行脚本 启动集群
 ./start.sh gen     # 生产固定配置信息的docker-compose.yml 文件到build 目录中
 ./start.sh info    # 查看集群运行状态
 ./start.sh stop    # 停止集群
 ./start.sh reload  # 集群热重重启
 ./start.sh restart # 集群重启
```

默认 docker-compose.yml 启动 4 个(官网推荐个数) consul 节点 一主多从, restart 策略 :on-failure

映射 数据持久化目录 到宿主急的 /data/consul 目录中
映射 服务端口 8300(rpc), 8500(http)

[官方的 dockerfile 仓库](https://github.com/hashicorp/docker-consul.git)
