#!/bin/bash

set -e

ROOT_USER_ID=0
DEFAULT_USER_ID=1000

if [ -v USER_ID ] && [ "$USER_ID" != "$ROOT_USER_ID" ]; then
    usermod --uid $USER_ID ros1
    find /home/ros1 -user $DEFAULT_USER_ID -exec chown -h $USER_ID {} \;
fi

cd /home/ros1

echo ""
echo "ROS1"
echo ""

if [ -z "$1" ]; then
    su ros1 -c "/bin/bash"
else
    su ros1 -c "exec \"$@\""
fi