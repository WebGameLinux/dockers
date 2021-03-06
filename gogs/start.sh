#!/bin/bash

curDir=$(cd `dirname $0`; pwd)

# 初始化持久化目录
function initDataDir(){
    if [ "${data_dir}x" == "x" ];then
        return
    fi
    # 新建存放数据的目录
    if [ ! -e ${data_dir} ];then
        mkdir -p ${data_dir}
        chmod  -R 777 ${data_dir}
    fi
    # 新建备份数据的目录
    if [ ! -e ${backup_dir} ];then
        mkdir -p ${backup_dir}
        chmod  -R 777  ${backup_dir}
    fi
    # 新建用户家目录
    if [ ! -e ${user_home} ];then
        mkdir -p ${user_home}
        chmod  -R 777  ${user_home}
    fi
}

# 初始化git用户
function initUser(){
    if [ "${user}x" == "x" ];then
        return
    fi
    if [ "${user_group}x" == "x" ];then
        export user_group=1000
    fi
    id $user >& /dev/null
    if [ $? -ne 0 ];then
        adduser  ${user} -u ${user_group}
    fi
    ## 初始化
    if [ ! -e "/home/${user}/.ssh" ];then
        ln -s ${data_dir}/gogs/git/.ssh  /home/${user}/.ssh
        ## 非交互
        ssh-keygen -t rsa -b 4096 -f /home/${user}/.ssh/id_rsa  -P ""
        pub=`cat /home/${user}/.ssh/id_rsa.pub`
        auth="/home/${user}/.ssh/authorized_keys"
        old=""
        if [ -e "${auth}" ];then
            old=`cat ${auth}`
        fi
        ## 追加到头部
        echo "command=\"/app/gogs/gogs serv key-1 --config='/data/gogs/conf/app.ini'\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ${pub}\n${old}" \
        > ${auth}
    fi
}

## 启动ssh服务
function initSsh(){
    ## 创建gogs
    if [ ! -e /app/gogs/ ];then
        mkdir -p /app/gogs/
        cat >/app/gogs/gogs <<END
#!/bin/bash
GIT_KEY_ID=\$(cat /home/git/.ssh/id_rsa.pub | awk '{ print $3 }')
if ! grep -q "no-port.*\$GIT_KEY_ID" /home/git/.ssh/authorized_keys
then
    echo \
    "no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty" \
    "\$(cat /home/git/.ssh/id_rsa.pub)" \
    >> /home/git/.ssh/authorized_keys
fi
ssh -p ${ssh_port} -o StrictHostKeyChecking=no git@127.0.0.1 -p ${system_ssh_port} \
    SSH_ORIGINAL_COMMAND=\$(printf '%q' "\$SSH_ORIGINAL_COMMAND") "\$0" "\$@"
END
        chmod 755 /app/gogs/gogs
        /app/gogs/gogs &
    fi
    ## 检查ssh 共享
    check=`ps -ef|grep "/app/gogs/gogs"|grep -v grep|grep -v git`
    if [ "${check}" == "" ];then
        sshTest
    fi
}

## 创建 ssh 测试配置
function initSshConf(){
    if [ ! -e ${curDir}/config/ ];then
      mkdir -p ${curDir}/config
    fi
    ## 创建gogs
    if [ ! -e ${curDir}/config/config ];then
        cat >${curDir}/config/config <<END
Host ${gogs_user}
    HostName 127.0.0.1
    User ${user}
    Port ${ssh_port}
    IdentitiesOnly yes
    IdentityFile /home/${user}/.ssh/id_rsa
END
    fi
}

# 测试 ssh
function sshTest(){
    initSshConf
    ssh -T ${gogs_user} -F ${curDir}/config/config 2&>1
    if [ ! -e "./1" ];then
        return
    fi
    ok=`cat ./1|grep "Authentication succeeded"`
    if [ "${ok}x" == "x" ];then
        echo "ssh test succeeded"
    else
        echo "ssh failed"
    fi
    rm -f ./1
}

## stop ssh
function stopSsh(){
    check=`ps -ef|grep "/app/gogs/gogs"|grep -v grep|grep -v git`
    if [ "${check}" == "" ];then
        return
    fi
    echo ${check}| awk '{print $2}' | xargs kill -9
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
            initUser
            initSsh
        ;;
        restart)
            restart
        ;;
        ssh)
          initUser
          initSsh
        ;;
        ssh-test)
          sshTest
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
        echo "script support options : gen,start,ssh,stop,ssh-test,reload,clean,delete,restart"
    esac
}

# 执行主逻辑
main ${@}

# 回到原目录
cd -

exit 0
