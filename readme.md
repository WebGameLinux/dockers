# 开发环境搭建 工具包

项目宗旨:
帮助开发人员和运维人员 快速部署开发、测试 环境

> 希望你---百练成仙

## docs

dockerfile 和 docker-compose.yml 相关简介于编写示例

## [Apollo](https://github.com/ctripcorp/apollo)

（阿波罗）是携程框架部门研发的分布式配置中心，能够集中化管理应用不同环境、不同集群的配置，配置修改后能够实时推送到应用端，并且具备规范的权限、流程治理等特性，适用于微服务配置管理场景。(java)

## [Zookeeper](https://github.com/apache/zookeeper)

分布式存储服务, 仅提供 tcp 服务, java 和 golang 开发使用较多 (java)

## [RabbitMq](https://github.com/rabbitmq/rabbitmq-server)

消息队列 (erlang)
提供 http api 服务

## [Redis](https://github.com/antirez/redis)

基于内存的 缓存数据库, 支持多种数据结构的存储 , 提供网络服务 (c)

## [Mysql](https://github.com/MariaDB/server)

经久不衰的 关系型数 据库 (cpp)

目前 开源社区 使用 MariaDB (mysql 开源版本)

## [MongoDB](https://github.com/mongodb/mongo)

json 数据库 NoSql 数据库 非关系型数据库 (nodejs)

基于 V8 engine bson 数据库

## [PostgresSQL](https://www.postgresql.org)

PostgreSQL 是一个功能强大的开放源代码对象关系数据库系统，经过 30 多年的积极开发，在可靠性，功能强大和性能方面赢得了极高的声誉。
[git](https://git.postgresql.org/gitweb/?p=postgresql.git)

## [Etcd](https://github.com/etcd-io/etcd.git)

etcd kv 存储服务, 可以用于分布存储(分布式锁,配置中心)

## [Consul](https://github.com/hashicorp/consul)

用于 微服务 的服务信息注册 ,服务发现

## [Elasticsearch](https://github.com/elastic/elasticsearch)

提供 全文搜索功能 http 搜索服务 api 的 搜索引擎

## [Kibana](https://github.com/elastic/kibana)

提供 可视化 es 系列 工具 (java,js,css,html)

## [Logstash](https://github.com/elastic/logstash)

日志分享, 日志收集服务 (java)

## [Nacos](https://nacos.io/zh-cn/docs/what-is-nacos.html)

阿里开发的 一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。(java)

## [Eureka](https://github.com/Netflix/eureka)

微服务 服务注册中心 (java)

## [Istio](https://istio.io/zh/docs/concepts/what-is-istio/)

service mesh (下一代微服务架构:服务网格)服务套件 需要与 k8s 结合使用

## [K8s](https://github.com/kubernetes/kubernetes)

Kubernetes 是 google 内部研发的 docker 编排、服务管理 系统 (go)

## [Grafana](https://github.com/grafana/grafana.git)

用于 Graphite，InfluxDB 和 Prometheus 等的精美监视和指标分析和仪表板的工具

## [Influxdb](https://github.com/influxdata/influxdb)

InfluxDB 是一个开源时间序列平台。这包括用于存储和查询数据，在后台处理数据以实现 ETL 或监视和警报目的的 API，用户仪表板以及可视化和探索数据的 API 等。现在，此仓库中的 master 分支代表最新的 InfluxDB，该数据库现在在单个二进制文件中包含针对 Kapacitor（后台处理）和 Chronograf（UI）的功能。(golang)

## Todo

成仙计划集成

- [x] Apollo
- [x] Zookeeper
- [ ] Redis
- [ ] Mysql
- [ ] RabbitMq
- [ ] MongoDB
- [ ] Elasticsearch
- [ ] Kibana
- [ ] Logstash
- [x] Etcd
- [x] Consul
- [ ] PostgresSQL
- [ ] Nacos
- [ ] Eureka
- [ ] Istio
- [ ] K8s
- [ ] Grafana
- [ ] InfluxDB
