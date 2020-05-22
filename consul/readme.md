# Consul

Consul 是一个服务网格（微服务间的 TCP/IP，负责服务之间的网络调用、限流、熔断和监控）解决方案，它是一个一个分布式的，高度可用的系统，而且开发使用都很简便。它提供了一个功能齐全的控制平面，主要特点是：服务发现、健康检查、键值存储、安全服务通信、多数据中心。

## 快速启动 consul 集群

启动脚本 使用 `start.sh`

启动方式:
bash 命令行

```bash
./start.sh start   # 启动
./start.sh stop    # 关闭
./start.sh restart # 重启
```

默认 docker-compose.yml 启动 4 个(官网推荐个数) consul 节点 一主多从, restart 策略 :on-failure

映射 数据持久化目录 到宿主急的 /data/consul 目录中
映射 服务端口 8300(rpc), 8500(http)
