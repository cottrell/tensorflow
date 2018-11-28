ARG UBUNTU_VERSION
ARG CUDA_VERSION
ARG CUDNN_VERSION
ARG NCCL_VERSION
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu${UBUNTU_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cuda-command-line-tools-${CUDA_VERSION} \
        cuda-cublas-dev-${CUDA_VERSION} \
        cuda-cudart-dev-${CUDA_VERSION} \
        cuda-cufft-dev-${CUDA_VERSION} \
        cuda-curand-dev-${CUDA_VERSION} \
        cuda-cusolver-dev-${CUDA_VERSION} \
        cuda-cusparse-dev-${CUDA_VERSION} \
        curl \
        git \
        libcudnn7=${CUDNN_VERSION}-1+cuda${CUDA_VERSION} \
        libcudnn7-dev=${CUDNN_VERSION}-1+cuda${CUDA_VERSION} \
        libnccl2=${NCCL_VERSION}-1+cuda${CUDA_VERSION} \
        libnccl-dev=${NCCL_VERSION}-1+cuda${CUDA_VERSION} \
        libcurl3-dev \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        wget \
        && \
    rm -rf /var/lib/apt/lists/* && \
    find /usr/local/cuda-${CUDA_VERSION}/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    rm /usr/lib/x86_64-linux-gnu/libcudnn_static_v7.a

# probably do not need infer
# RUN apt-get update && \
#         apt-get install nvinfer-runtime-trt-repo-ubuntu1604-4.0.1-ga-cuda${CUDA_VERSION} && \
#         apt-get update && \
#         apt-get install libnvinfer4=4.1.2-1+cuda${CUDA_VERSION} && \
#         apt-get install libnvinfer-dev=4.1.2-1+cuda${CUDA_VERSION}

# Link NCCL libray and header where the build script expects them.
RUN mkdir /usr/local/cuda-${CUDA_VERSION}/lib &&  \
    ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/lib/libnccl.so.2 && \
    ln -s /usr/include/nccl.h /usr/local/cuda/include/nccl.h

# TODO(tobyboyd): Remove after license is excluded from BUILD file.
RUN gunzip /usr/share/doc/libnccl2/NCCL-SLA.txt.gz && \
    cp /usr/share/doc/libnccl2/NCCL-SLA.txt /usr/local/cuda/
