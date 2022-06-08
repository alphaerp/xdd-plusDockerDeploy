#!/bin/sh

CODE_DIR=/xdd-plus

if [ "$ENABLE_GITHUBPROXY" = "true" ]; then
   GITHUBPROXY=https://ghproxy.com/
   echo "启用 github 加速 ${GITHUBPROXY}"
else
  echo "未启用 github 加速"
fi

if [ -z $REPO_URL ]; then
  REPO_URL=${GITHUBPROXY}https://github.com/764763903a/xdd-plus.git
fi


if [ ! -d $CODE_DIR/.git ]; then
  echo "xdd-plus 核心代码目录为空, 开始clone代码..."
  git clone $REPO_URL  $CODE_DIR
  wget -P $CODE_DIR -O xdd-linux-amd64 https://github.com/764763903a/xdd-plus/releases/download/v4.2/xdd-linux-amd64
  wget -P $CODE_DIR/qbot https://github.com//764763903a/xdd-plus/releases/download/v1.7/config.yml
  chmod +x ./xdd-linux-amd64
else 
  echo "xdd-plus 核心代码已存在"
  echo "更新 xdd-plus 核心代码"
  cd $CODE_DIR && git reset --hard && git pull
fi



echo "启动..."
 ./xdd-linux-amd64
