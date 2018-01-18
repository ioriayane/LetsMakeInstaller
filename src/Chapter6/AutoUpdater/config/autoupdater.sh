#!/bin/sh

APP_PATH="/opt/HelloWorld/maintenancetool"
SCRIPT_PATH=$(cd $(dirname $0) && pwd)/controlscript.qs

# 更新確認
$APP_PATH --checkupdates

if test $? -eq 0
then
echo 更新あり
$APP_PATH --updater --script $SCRIPT_PATH
else
echo 更新なし
fi

