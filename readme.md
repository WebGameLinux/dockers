# 开发环境搭建 工具包

项目宗旨:
帮助开发人员和运维人员 快速部署开发、测试 环境

## docs

dockerfile 和 docker-compose.yml 相关简介于编写示例

## [apollo](https://github.com/ctripcorp/apollo/wiki/Apollo%E9%85%8D%E7%BD%AE%E4%B8%AD%E5%BF%83%E4%BB%8B%E7%BB%8D)

（阿波罗）是携程框架部门研发的分布式配置中心，能够集中化管理应用不同环境、不同集群的配置，配置修改后能够实时推送到应用端，并且具备规范的权限、流程治理等特性，适用于微服务配置管理场景。

## Zookeeper

分布式存储服务, 仅提供 tcp 服务, java 和 golang 开发使用较多

## RabbitMq

消息队列

## Redis

基于内存的 缓存数据库, 支持多种数据结构的存储 , 提供网络服务(socket)

## Mysql

经久不衰的 关系型数 据库

## MongoDB

json 数据库 NoSql 数据库 非关系型数据库

基于 V8 engine bson 数据库

## PostgresSQL

## Etcd

etcd kv 存储服务, 可以用于分布存储(分布式锁,配置中心)

## consul

用于 微服务 的服务信息注册 ,服务发现

## elasticsearch

提供 全文搜索功能 http 搜索服务 api 的 搜索引擎

## kibana

提供 可视化 es 系列 工具

## logstash

日志分享, 日志收集服务

## [nacos](https://nacos.io/zh-cn/docs/what-is-nacos.html)

阿里开发的 一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。

## eureka

微服务 服务注册中心

## lstio

service mesh (下一代微服务架构:服务网格)服务套件

## grafana

时序 数据库, k8s 相关实时数据平台常用数据存储服务

## Todo

计划集成

- [x] zookeeper
- [ ] redis
- [ ] mysql
- [ ] rabbitMq
- [ ] MongoDB
- [ ] elasticsearch
- [ ] kibana
- [ ] logstash
- [x] etcd
- [x] consul
- [ ] postgresSQL
- [ ] nacos
- [ ] eureka
- [ ] lstio
- [ ] grafana
