readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR
docker run -it \
    --network host \
    --ipc host \
    --pid host \
    --env DISPLAY=$DISPLAY \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume "$(realpath ../Multi_ORB_SLAM)":"/ws/src/Multi_ORB_SLAM" \
    multi-orb-slam
