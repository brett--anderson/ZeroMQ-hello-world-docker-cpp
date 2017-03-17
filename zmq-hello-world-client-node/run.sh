#!/usr/bin/env bash

OUTPUT="$(ps -ef | grep gdbserver | awk '/zmq_hello_world/ { print $2}')"
echo "gdbserver PID: $OUTPUT"
kill -9 "$OUTPUT"
OUTPUT="$(ps -aux | awk '/zmq_hello_world/' | awk 'NR==1{print $2}')"
echo "the running program $OUTPUT"
kill -9 "$OUTPUT"
sleep 5

# Out-of-source builds are recommended, as you can build multiple variants in separate directories, e.g., HelloBuildDebug, HelloBuildRelease.
# mkdir HelloBuild
# cd HelloBuild
# ccmake ../Hello
# make

mkdir debugBuild
cd debugBuild

/opt/cmake/bin/cmake -DCMAKE_BUILD_TYPE=Debug ../
make

# copy to output for remote debug
cp zmq_hello_world output/

gdbserver 127.0.0.1:7777 ./zmq_hello_world
