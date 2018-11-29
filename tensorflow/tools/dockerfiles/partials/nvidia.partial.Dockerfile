ARG UBUNTU_VERSION
ARG TF_CUDA_VERSION
FROM nvidia/cuda:${TF_CUDA_VERSION}-cudnn7-devel-ubuntu${UBUNTU_VERSION}

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
