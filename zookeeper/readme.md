# zookeeper

使用 Docker 命令行客户端连接 ZK 集群
通过 docker-compose ps 命令, 我们知道启动的 ZK 集群的三个主机名分别是 zoo1, zoo2, zoo3, 因此我们分别 link 它们即可:

```bash
docker run -it --rm \
        --link zoo1:zk1 \
        --link zoo2:zk2 \
        --link zoo3:zk3 \
        --net zktest_default \
        zookeeper zkCli.sh -server zk1:2181,zk2:2181,zk3:2181
```

注意:

```yml
# 运行所有ip 推荐仅用于开发,生成时按需要剔除
quorumListenOnAllIPs=true
```

## zookeeper 配置

[官方文档](https://zookeeper.apache.org/doc/current/zookeeperAdmin.html)

默认配置文件 conf/zoo.cfg

```cfg
# 单个刻度的长度，这是ZooKeeper使用的基本时间单位，以毫秒为单位。它用于调节心跳和超时。例如，最小会话超时将是两个刻度。
tickTime=2000
# 持久化存储目录
dataDir=/var/lib/zookeeper/
# 客户端链接端口
clientPort=2181
initLimit=5
syncLimit=2
# 复制集
server.1=zoo1:2888:3888
server.2=zoo2:2888:3888
server.3=zoo3:2888:3888
```
