
all: cpu-devel cpu-devel-jupyter cpu cpu-jupyter nvidia-devel nvidia-devel-jupyter nvidia nvidia-jupyter

assemble:
	python assembler.py

cpu-devel: assemble
	docker build -f dockerfiles/cpu-devel.Dockerfile -t cottrell/tensorflow:cpu-devel .

cpu-devel-jupyter: assemble
	docker build -f dockerfiles/cpu-devel-jupyter.Dockerfile -t cottrell/tensorflow:cpu-devel-jupyter .

cpu: assemble
	docker build -f dockerfiles/cpu.Dockerfile -t cottrell/tensorflow:cpu .

cpu-jupyter: assemble
	docker build -f dockerfiles/cpu-jupyter.Dockerfile -t cottrell/tensorflow:cpu-jupyter .

nvidia-devel: assemble
	docker build -f dockerfiles/nvidia-devel.Dockerfile -t cottrell/tensorflow:nvidia-devel .

nvidia-devel-jupyter: assemble
	docker build -f dockerfiles/nvidia-devel-jupyter.Dockerfile -t cottrell/tensorflow:nvidia-devel-jupyter .

nvidia: assemble
	docker build -f dockerfiles/nvidia.Dockerfile -t cottrell/tensorflow:nvidia .

nvidia-jupyter: assemble
	docker build -f dockerfiles/nvidia-jupyter.Dockerfile -t cottrell/tensorflow:nvidia-jupyter .
