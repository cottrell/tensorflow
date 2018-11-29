#!/bin/sh

# docker run -it $(whoami)/tensorflow:nvidia-devel ...
# watch out, python is now python2.7 likely from bazel install
# pip appears to be pip3 though
cd /usr/bin
[ -e python ] && rm python
ln -s python3 python
cd -
pip install pip six numpy wheel mock
# might need to specify versions:
pip install keras_applications
pip install keras_preprocessing
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout v1.12.0-rc2

# now in the devel dockerfile build
# apt-get install -y libc-ares-dev

# test
# for r1.12 and before
bazel test -c opt -- //tensorflow/... -//tensorflow/compiler/... -//tensorflow/contrib/lite/...
# for after r.1.12
# bazel test -c opt -- //tensorflow/... -//tensorflow/compiler/... -//tensorflow/lite/...

./configure

# build pip package
# cpu
# bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
# gpu
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package

# then run the package builder, probably need to bind mount at the top to get at this
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
