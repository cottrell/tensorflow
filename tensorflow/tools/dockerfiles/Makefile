# file produced by helper.sh

all: cpu-devel cpu-devel-jupyter cpu cpu-jupyter nvidia-devel nvidia-devel-jupyter nvidia nvidia-jupyter

assemble: spec.yml partials/bazel.partial.Dockerfile partials/jupyter.partial.Dockerfile partials/nvidia-devel.partial.Dockerfile partials/nvidia.partial.Dockerfile partials/python.partial.Dockerfile partials/shell.partial.Dockerfile partials/tensorflow.partial.Dockerfile partials/ubuntu-devel.partial.Dockerfile partials/ubuntu.partial.Dockerfile
	python assembler.py

cpu-devel: assemble
	docker build -f dockerfiles/cpu-devel.Dockerfile -t cottrell/tensorflow:cpu-devel . | tee logs/cpu-devel.log

cpu-devel-jupyter: assemble
	docker build -f dockerfiles/cpu-devel-jupyter.Dockerfile -t cottrell/tensorflow:cpu-devel-jupyter . | tee logs/cpu-devel-jupyter.log

cpu: assemble
	docker build -f dockerfiles/cpu.Dockerfile -t cottrell/tensorflow:cpu . | tee logs/cpu.log

cpu-jupyter: assemble
	docker build -f dockerfiles/cpu-jupyter.Dockerfile -t cottrell/tensorflow:cpu-jupyter . | tee logs/cpu-jupyter.log

nvidia-devel: assemble
	docker build -f dockerfiles/nvidia-devel.Dockerfile -t cottrell/tensorflow:nvidia-devel . | tee logs/nvidia-devel.log

nvidia-devel-jupyter: assemble
	docker build -f dockerfiles/nvidia-devel-jupyter.Dockerfile -t cottrell/tensorflow:nvidia-devel-jupyter . | tee logs/nvidia-devel-jupyter.log

nvidia: assemble
	docker build -f dockerfiles/nvidia.Dockerfile -t cottrell/tensorflow:nvidia . | tee logs/nvidia.log

nvidia-jupyter: assemble
	docker build -f dockerfiles/nvidia-jupyter.Dockerfile -t cottrell/tensorflow:nvidia-jupyter . | tee logs/nvidia-jupyter.log
