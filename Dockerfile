FROM ros:noetic

# Based on MultiCol-SLAM
RUN apt-get clean && apt-get update -y && apt-get upgrade -y
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    sudo \
    wget \
    ninja-build \
    software-properties-common \
    python3 \
    python3-pip \
    ssh \
    gcc \
    g++ \
    gdb \
    cmake \
    rsync \
    tar \
    x11-utils \
    x11-apps \
    zip \
    libboost-all-dev libssl-dev

# Pangolin (based on MultiCol-SLAM)
RUN apt-get install -y \
    mesa-utils \
    libgl1-mesa-glx \
    libglu1-mesa-dev \
    libglew-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \ 
    mesa-common-dev

RUN apt-get install -y libeigen3-dev
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.zip && \
    unzip v0.6.zip && \
    cd Pangolin-0.6 && \
    mkdir build && cd build && \
    cmake -DCMAKE_CXX_STANDARD=11 .. && \
    make -j2 && \
    make install && \
    cd ../../

# OpenCV (based on MultiCol-SLAM)
RUN apt-get install -y \
    cmake \
    git \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libavresample-dev
RUN apt-get install -y libopencv-dev

# Clone the repository
RUN mkdir -p /ws/src && \
    cd /ws/src && \
    git clone https://github.com/j-karwowski/Multi_ORB_SLAM_CoRE.git -b core/devel Multi_ORB_SLAM
WORKDIR /ws/src/Multi_ORB_SLAM
# Build the Multi ORB-SLAM
# RUN sh build.sh

# Just for potentially mounting a volume (and run rosbag inside a container)
RUN mkdir /dataset

# Install comparible OpenCV version
RUN wget https://github.com/opencv/opencv/archive/refs/tags/3.4.16.zip && \
    unzip 3.4.16.zip
RUN cd opencv-3.4.16 && \
    mkdir build && cd build && \
    cmake .. && \
    make -j2 && \
    make install && \
    cd ../../
