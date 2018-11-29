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
    bash bazel-0.18.1-installer-linux-x86_64.sh && \
    rm bazel-0.18.1-installer-linux-x86_64.sh


