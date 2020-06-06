FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

ARG ROS_DISTRO="melodic"
ARG USER_ID="1000"
ARG GROUP_ID="15214"
ARG USER_NAME="ros1"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y \
        sudo \
        bash-completion

RUN groupadd --gid $GROUP_ID $USER_NAME && \
    useradd --gid $GROUP_ID -m $USER_NAME && \
    echo "$USER_NAME:$USER_NAME" | chpasswd && \
    usermod --shell /bin/bash $USER_NAME && \
    usermod -aG sudo $USER_NAME && \
    usermod  --uid $USER_ID $USER_NAME && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME && \
    gpasswd -a $USER_NAME video

RUN apt-get update && \
    apt-get install -y \
        tzdata \
        wget \
        gnupg \
        lsb-release && \
    echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libpng16-16 \
        python-catkin-tools \
        python-rosinstall-generator \
        ros-${ROS_DISTRO}-desktop-full \
        ros-${ROS_DISTRO}-ackermann-msgs \
        ros-${ROS_DISTRO}-derived-object-msgs \
        ros-${ROS_DISTRO}-tf \
        ros-${ROS_DISTRO}-cv-bridge \
        ros-${ROS_DISTRO}-pcl-conversions \
        ros-${ROS_DISTRO}-pcl-ros \
        ros-${ROS_DISTRO}-ainstein-radar \
        python-pip \
        python-rosdep \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    rosdep init

USER $USER_NAME
WORKDIR /home/$USER_NAME
ENV ROSDISTRO ${ROS_DISTRO}

RUN source /opt/ros/${ROSDISTRO}/setup.bash && \
    rosdep update && \
    echo "source /opt/ros/${ROSDISTRO}/setup.bash" >> ~/.bashrc && \
    echo "if [[ -f ~/catkin_ws/devel/setup.bash ]]; then" >> ~/.bashrc && \
    echo "    source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    echo "fi" >> ~/.bashrc

USER root
WORKDIR /root
ENV ROSDISTRO ${ROS_DISTRO}

COPY ./entrypoint.sh /tmp/entrypoint.sh

ENTRYPOINT [ "/tmp/entrypoint.sh" ]