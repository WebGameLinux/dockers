# certbot letsencrypt 客户端

letsencrypt(非盈利组) ssl 证书签发 工具

相关启动参数 比如 `volumes,ports` 的自定义可以通过改变 `envs` 目录中的变量
再使用 `start.sh gen` 生成对应业务部署的 yml 文件

镜像提供给的服务 :
端口: 443,80

存储目录: /etc/letsencrypt,/var/lib/letsencrypt

## 启动

第一次启动请使用 : `start.sh`

```bash
 ./start.sh         # 运行脚本 启动服务
 ./start.sh gen     # 生产固定配置信息的docker-compose.yml 文件到build 目录中
 ./start.sh info    # 查看服务运行状态
 ./start.sh stop    # 停止服务
 ./start.sh reload  # 服务热重重启
 ./start.sh restart # 服务重启
```
