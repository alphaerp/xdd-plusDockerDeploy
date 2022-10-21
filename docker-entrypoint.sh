#!/bin/sh

CODE_DIR=/xdd-plus

if [  "$ENABLE_GOPROXY" = "true" ]; then
  export GOPROXY=https://goproxy.io,direct 
  echo "启用 goproxy 加速 ${GOPROXY}"
else
  echo "未启用 goproxy 加速"
fi

if [ "$ENABLE_APKPROXY" = "true" ]; then
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
  echo "启用 alpine APK 加速 mirrors.aliyun.com"
else
  sed -i 's/mirrors.aliyun.com/dl-cdn.alpinelinux.org/g' /etc/apk/repositories
  echo "未启用 alpine APK 加速"
fi

if [ "$ENABLE_GITHUBPROXY" = "true" ]; then
   GITHUBPROXY=https://ghproxy.com/
   echo "启用 github 加速 ${GITHUBPROXY}"
else
  echo "未启用 github 加速"
fi

if [ -z $REPO_URL ]; then
  REPO_URL=${GITHUBPROXY}https://github.com/codeboysky/xdd-plus-1.git
fi


if [ ! -d $CODE_DIR/.git ]; then
  echo "xdd-plus 核心代码目录为空, 开始clone代码..."
  git clone $REPO_URL  $CODE_DIR
  wget -O $CODE_DIR/qbot/config.yml https://github.com/764763903a/xdd-plus/releases/download/v1.7/config.yml
else 
  echo "xdd-plus 核心代码已存在"
  echo "更新 xdd-plus 核心代码"
  cd $CODE_DIR && git reset --hard && git pull
fi

if [ -f "./xdd-plus" ]; then
  rm -rf ./xdd-plus
fi
go build -o ./xdd-plus
chmod +x ./xdd-plus


echo "启动..."
 ./xdd-plus
