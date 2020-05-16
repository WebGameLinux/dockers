# Apollo 配置中服务

阿里开源的 配置中方心解决方案

启动目录必须带上sql目录

## 说明

DEV,FAT,UAT,PRO 环境目前指向了同一个实例

环境分离推荐 将每个环境启动各自最少一个实例

可以以此为启动原型, 启动后修改系统参数: apollo.portal.envs, apollo.portal.meta.servers
