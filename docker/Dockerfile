FROM ros:humble

# Disable terminal interaction for apt
ENV DEBIAN_FRONTEND=noninteractive

# Make default shell in Dockerfile bash instead of sh
SHELL ["/bin/bash", "-c"]

# Setup workspace and some handy env variables
ENV ROS2_WS=/workspaces/ros2_ws
ENV TB_WS=/workspaces/tb_ws
RUN mkdir -p ${ROS2_WS}/src && \
    mkdir -p ${TB_WS}/src

ENV ROS_LOG_DIR=/workspaces/logs
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV IGN_GAZEBO_RESOURCE_PATH=/.gazebo

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

# Utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    git \
    build-essential \
    nano \
    vim \
    wget \
    curl \
    lsb-release \
    python3-pip \
    iputils-ping \
    htop \
    software-properties-common \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Fix black screen issue for Gazebo
RUN apt-get update && \
    add-apt-repository ppa:kisak/kisak-mesa && \
    apt-get install -y --no-install-recommends \    
    mesa-utils \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Turtlebot dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-dev-tools \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-turtlebot4-msgs \
    ros-humble-turtlebot4-navigation \
    ros-humble-turtlebot4-node \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Simulation
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ignition-fortress \
    ros-humble-turtlebot4-simulator \
    ros-humble-turtlesim \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Turtlebot robot 
RUN git clone -b humble https://github.com/turtlebot/turtlebot4_robot.git ${TB_WS}/src/turtlebot4_robot && \
    apt-get update && \
    cd ${TB_WS} && \
    rosdep install --from-path src -yi && \
    . /opt/ros/humble/setup.bash && \
    colcon build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ros2_ws/src ${ROS2_WS}/src
RUN cd ${ROS2_WS} && \
    . /opt/ros/humble/setup.bash && \
    rosdep install --from-paths src --ignore-src -r -y --rosdistro ${ROS_DISTRO} && \
    colcon build --symlink-install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Source ros and the workspace(s) automatically when new terminal is opened
RUN echo ". /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo ". ${ROS_WS}/install/setup.bash" >> ~/.bashrc && \
    echo ". ${TB_WS}/install/setup.bash" >> ~/.bashrc

# Fix autocompletion
RUN echo 'eval "$(register-python-argcomplete3 colcon)"' >> /opt/ros/humble/setup.sh

COPY docker/ros_entrypoint.sh /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]