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
