FROM osrf/ros:foxy-desktop

RUN apt update \
    && apt install -y curl \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && apt update \
    && apt install -y ros-foxy-perception-pcl \
    && apt install -y ros-foxy-pcl-msgs \
    && apt install -y ros-foxy-vision-opencv \
    && apt install -y ros-foxy-xacro \
    && rm -rf /var/lib/apt/lists/*

RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:borglab/gtsam-release-4.0 \
    && apt update \
    && apt install -y libgtsam-dev libgtsam-unstable-dev \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c", "mkdir -p ~/ros2_ws/src"]

RUN mkdir -p ~/ros2_ws/src \
    && cd ~/ros2_ws/src \
    && git clone -b ros2 https://github.com/kyu8456/ros2_liosam.git \
    && cd .. \
    && source /opt/ros/foxy/setup.bash \
    && colcon build

RUN echo "source /opt/ros/foxy/setup.bash" >> /root/.bashrc \
    && echo "source /root/ros2_ws/devel/setup.bash" >> /root/.bashrc

WORKDIR /root/ros2_ws
