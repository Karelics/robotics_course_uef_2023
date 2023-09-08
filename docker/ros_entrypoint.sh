#!/bin/bash
set -e

. "/opt/ros/humble/setup.bash"
. "${ROS2_WS}/install/setup.bash"

exec "$@"
