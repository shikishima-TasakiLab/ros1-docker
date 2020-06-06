#!/bin/bash
ROS_DISTRO="melodic"

BUILD_DIR=$(dirname $(readlink -f $0))
PROG_NAME=$(basename $0)

function usage_exit {
  cat <<_EOS_ 1>&2
  Usage: $PROG_NAME [OPTIONS...]
  OPTIONS:
    -h, --help                      このヘルプを表示

  Example: $PROG_NAME --version $CARLA_VERSION --ros-distro $ROS_DISTRO
_EOS_
    exit 1
}

while (( $# > 0 )); do
    if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
        usage_exit
    else
        echo "無効なパラメータ： $1"
        usage_exit
    fi
done

docker build \
    --build-arg ROS_DISTRO=${ROS_DISTRO} \
    -t ros1:${ROS_DISTRO} \
    ${BUILD_DIR}/src

if [[ $? != 0 ]]; then
    echo "エラーにより中断しました．"
    exit 1
fi
