cmake_minimum_required(VERSION 3.6)
project(ZeroMQ_hello_world_docker_cpp)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES
        zmq-hello-world-client-node/src/hwclient.cpp
        zmq-hello-world-client-node/CMakeLists.txt
        zmq-hello-world-client-node/Dockerfile
        zmq-hello-world-server-node/src/hwserver.cpp
        zmq-hello-world-server-node/CMakeLists.txt
        zmq-hello-world-server-node/Dockerfile
        docker-compose.yml
        README.md)

add_executable(ZeroMQ_hello_world_docker_cpp ${SOURCE_FILES})