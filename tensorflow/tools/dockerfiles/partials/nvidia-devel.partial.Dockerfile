ARG UBUNTU_VERSION
ARG TF_CUDA_VERSION
FROM nvidia/cuda:${TF_CUDA_VERSION}-cudnn7-devel-ubuntu${UBUNTU_VERSION}
# yes, this needs to be before *and* after or just hard-code the above. https://stackoverflow.com/questions/50291827/why-cant-i-use-the-build-arg-again-after-from-in-a-dockerfile
# could also use ENV TF_CUDA_VERSION=$TF_CUDA_VERSION or something like that but then you persist the ENV var.
ARG TF_CUDA_VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
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
    find /usr/local/cuda-${TF_CUDA_VERSION}/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    rm /usr/lib/x86_64-linux-gnu/libcudnn_static_v7.a

# Not sure if this are still needed
# # Link NCCL libray and header where the build script expects them.
# RUN mkdir /usr/local/cuda-${TF_CUDA_VERSION}/lib &&  \
#     ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/lib/libnccl.so.2 && \
#     ln -s /usr/include/nccl.h /usr/local/cuda/include/nccl.h

# # TODO(tobyboyd): Remove after license is excluded from BUILD file.
# RUN gunzip /usr/share/doc/libnccl2/NCCL-SLA.txt.gz && \
#     cp /usr/share/doc/libnccl2/NCCL-SLA.txt /usr/local/cuda/
