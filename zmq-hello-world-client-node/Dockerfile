FROM ubuntu:14.04

# Setup ZMQ

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential libtool autoconf automake pkg-config unzip libkrb5-dev
RUN cd /tmp && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && git checkout e2a30a && ./autogen.sh && ./configure && make check && make install && ldconfig
RUN cd /tmp && git clone --depth 1 --branch v4.2.1 https://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make
# RUN cd /tmp/libzmq && make check
RUN cd /tmp/libzmq && make install && ldconfig
RUN rm /tmp/* -rf

# Setup CMake

RUN apt-get install wget -y
RUN wget https://cmake.org/files/v3.6/cmake-3.6.3.tar.gz -P /tmp/
RUN tar xzf /tmp/cmake-3.6.3.tar.gz -C /tmp/
RUN cd /tmp/cmake-3.6.3 && ./configure --prefix=/opt/cmake && make -j4 && make install
RUN /opt/cmake/bin/cmake -version
RUN rm /tmp/* -rf

# Add ZMQ files needed for C++
RUN cd /tmp && git clone --depth 1 --branch v4.2.1 https://github.com/zeromq/cppzmq.git && cp cppzmq/zmq.hpp /usr/local/include/zmq.hpp


# Setup Hello World example

RUN mkdir -p /opt/hello-world
WORKDIR /opt/hello-world

COPY . /opt/hello-world

RUN /opt/cmake/bin/cmake .
RUN make

EXPOSE 5555

CMD ./zmq_hello_world