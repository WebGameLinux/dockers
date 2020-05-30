# [gogs](https://github.com/gogs/gogs) Git 版本服务

应用服务[镜像](https://hub.docker.com/r/gogs/gogs)为 gogs 官方提供 版本为 latest

拉取镜像命令如下:

```bash
docker pull gogs/gogs
```

相关启动参数 比如 `volumes,ports` 的自定义可以通过改变 `envs` 目录中的变量
再使用 `start.sh gen` 生成对应业务部署的 yml 文件

注: 拉取镜像慢请使用 阿里云 docker 镜像加速

## 启动

第一次启动请使用 : `start.sh`

```bash
 ./start.sh          # 运行脚本 服务器启动
 ./start.sh gen      # 生产固定配置信息的docker-compose.yml 文件到build 目录中
 ./start.sh info     # 查看服务运行状态
 ./start.sh stop     # 停止服务
 ./start.sh reload   # 服务热重重启
 ./start.sh restart  # 服务重启
 ./start.sh ssh-test # 测试git的ssh服务
```

## ssh 使用

客户端 ssh 相关配置(~/.ssh/config)

```config
# 别名用户自定义亦可以
Host gogs
    # 域名按实际情况填写
    HostName gogs.yourdomain.com
    # 端口按实际情况填写
    Port  22
    # 私钥按用户实际目录填写
    IdentityFile ~/.ssh/gogs_id_rsa
    # 必选
    IdentitiesOnly yes
```
