#!/bin/bash

curDir=$(cd `dirname $0`; pwd)

# 初始化持久化目录
function initDataDir(){
    if [ "${data_dir}x" == "x" ];then
        return
    fi
    #新建存放vscode数据的目录
    if [ ! -e ${data_dir} ];then
        mkdir -p ${data_dir}
        chmod  -R 777 ${data_dir}
    fi
}

# 启动
function start(){
    docker-compose up -d
}

# 启动
function restart(){
    docker-compose restart
}

# 停止
function stop(){
    docker-compose stop
}

# 删除
function delete(){
    docker-compose stop
    docker-compose rm -f
}

# 重新加载
function reload(){
    docker-compose reload
}

# 查看
function info(){
    docker-compose ps
}

# 生成固定配置启动yml
function create(){
   ./build.py
   echo "生成docker-compose.yml文件成功,请查看build文件夹"
}

# 检查 docker-compose 是否已安装
type docker-compose >/dev/null 2>&1
if [ "{$?}x" == "1x" ]; then
   echo "docker-compose not found,please install docker-compose and export to environment path"
   exit 1
fi

cd ${curDir}
# 加载基础环境环境变量
source ./envs/base.env

# 主要逻辑
function main(){
    opt=$1
    if [ "${opt}x" == "x" ];then
      opt="start"
    fi
    case ${opt} in
        start)
            initDataDir
            start
        ;;
        restart)
            restart
        ;;
        stop)
            stop
        ;;
        reload)
            reload
        ;;
        clean|delete)
            delete
        ;;
        ps|info)
            info
        ;;
        make|create|gen)
           create
        ;;
        *|help)
        echo "script support options : gen,start,stop,reload,clean,delete,restart"
    esac
}

# 执行主逻辑
main ${@}

# 回到原目录
cd -

exit 0
