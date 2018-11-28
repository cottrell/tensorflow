ARG UBUNTU_VERSION
ARG CUDA_VERSION
ARG CUDNN_VERSION
ARG NCCL_VERSION
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu${UBUNTU_VERSION}

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cuda-command-line-tools-${CUDA_VERSION} \
        cuda-cublas-${CUDA_VERSION} \
        cuda-cufft-${CUDA_VERSION} \
        cuda-curand-${CUDA_VERSION} \
        cuda-cusolver-${CUDA_VERSION} \
        cuda-cusparse-${CUDA_VERSION} \
        libcudnn7=${CUDNN_VERSION}-1+cuda${CUDA_VERSION} \
        libnccl2=${NCCL_VERSION}-1+cuda${CUDA_VERSION} \
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

# probably do not need infer
# RUN apt-get update && \
#         apt-get install nvinfer-runtime-trt-repo-ubuntu1604-4.0.1-ga-cuda${CUDA_VERSION} && \
#         apt-get update && \
#         apt-get install libnvinfer4=4.1.2-1+cuda${CUDA_VERSION}
