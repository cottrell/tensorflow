# Copyright 2018 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================
#
# THIS IS A GENERATED DOCKERFILE.
#
# This file was assembled from multiple pieces, whose use is documented
# below. Please refer to the the TensorFlow dockerfiles documentation for
# more information. Build args are documented as their default value.
#
# Ubuntu-based, Nvidia-GPU-enabled environment for developing changes for TensorFlow, with Jupyter included.
#
# Start from Nvidia's Ubuntu base image with CUDA and CuDNN, with TF development
# packages.
# --build-arg UBUNTU_VERSION=18.04
#    ( no description )
# --build-arg TF_CUDA_VERSION=9.2
#    ( no description )
#
# Python is required for TensorFlow and other libraries.
# --build-arg USE_PYTHON_3_NOT_2=True
#    Install python 3 over Python 2
#
# Install the latest version of Bazel and Python development tools.
#
# Configure TensorFlow's shell prompt and login tools.
#
# Launch Jupyter on execution instead of a bash prompt.

ARG UBUNTU_VERSION=18.04
ARG TF_CUDA_VERSION=9.2
FROM nvidia/cuda:${TF_CUDA_VERSION}-cudnn7-devel-ubuntu${UBUNTU_VERSION}
# yes, this needs to be before *and* after or just hard-code the above. https://stackoverflow.com/questions/50291827/why-cant-i-use-the-build-arg-again-after-from-in-a-dockerfile
# could also use ENV TF_CUDA_VERSION=$TF_CUDA_VERSION or something like that but then you persist the ENV var.
ARG TF_CUDA_VERSION=9.2

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

ARG USE_PYTHON_3_NOT_2=True
ARG _PY_SUFFIX=${USE_PYTHON_3_NOT_2:+3}
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    ${PYTHON} \
    ${PYTHON}-pip

RUN ${PIP} install --upgrade \
    pip \
    setuptools

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    openjdk-8-jdk \
    ${PYTHON}-dev \
    swig

# not sure about this one
RUN apt-get install -y gpg-agent

# Install bazel
# https://github.com/tensorflow/tensorflow/issues/23554
# RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
#     curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
#     apt-get update && \
#     apt-get install -y bazel

# do I need python in this list?
RUN apt-get install -y pkg-config zip g++ zlib1g-dev unzip libc-ares-dev && \
    wget https://github.com/bazelbuild/bazel/releases/download/0.18.1/bazel-0.18.1-installer-linux-x86_64.sh && \
    bash bazel-0.18.1-installer-linux-x86_64.sh



COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

RUN ${PIP} install jupyter

RUN mkdir /notebooks && chmod a+rwx /notebooks
RUN mkdir /.local && chmod a+rwx /.local
WORKDIR /notebooks
EXPOSE 8888

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/notebooks --ip 0.0.0.0 --no-browser --allow-root"]
