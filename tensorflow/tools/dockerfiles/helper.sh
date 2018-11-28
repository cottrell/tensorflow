#!/bin/bash
# print a makefile
all=$(ls dockerfiles/*.Dockerfile)
echo
echo all: $(for x in $all; do
    basename $x | cut -d. -f1
done)
echo
echo assemble:
echo "	python assembler.py"
for x in $all; do
    b=$(basename $x | cut -d. -f1)
    echo
    echo $b: assemble
    echo "	docker build -f $x -t $(whoami)/tensorflow:$b ."
done
