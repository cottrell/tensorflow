#!/bin/bash
# print a makefile
all=$(ls dockerfiles/*.Dockerfile)
echo "# file produced by helper.sh"
echo
echo all: $(for x in $all; do
    basename $x | cut -d. -f1
done)
echo
echo assemble: spec.yml partials/*.Dockerfile
echo "	python assembler.py"
mkdir -p logs
for x in $all; do
    b=$(basename $x | cut -d. -f1)
    echo
    echo $b: assemble
    echo "	docker build -f $x -t $(whoami)/tensorflow:$b . | tee logs/$b.log"
done
