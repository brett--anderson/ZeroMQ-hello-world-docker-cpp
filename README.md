# ZeroMQ Hello World with Docker

This project runs the first example in C++ from the ØMQ guide located [here](http://zguide.zeromq.org/page:all). The Docker containers take care of all the install instructions needed to get up and running with C++ and ØMQ.

## Getting Started

Assuming you already have Docker installed on your system, run the following command to create a virtual network which the client and server will communicate over using ØMQ.

```
docker network create zmq
```

Then run the following command from the project root to build the client and server environments and run the 'Hello World' example:

```
docker-compose up --build
```

This will run both the client and server and you should see the output of the client and server as one sends messages to the other. After the client has sent 10 messages it will automatically exit, leaving the server running. To stop the server just enter `ctrl-c`

## Using a different version of ZeroMQ or CMake

In each of the Docker files in the `zmq-hello-world-client-node` and `zmq-hello-world-server-node` directories, search for the text `--branch v4.2.1`. This can be changed to any relase tags at https://github.com/zeromq/libzmq

## Running the server and client independently

Assuming you already have Docker installed on your system, run the following command to create a virtual network which the client and server will communicate over using ØMQ.

```
docker network create zmq
```

To run the client container directly navigate to the zmq-hello-world-client-node folder and run

```
docker build .
```

 When this completes you will see a message: `Successfully built daf63168161f`. Note that the ID at the end of the message will be different. Copy the ID and enter the command: 

 ```
 docker run -it --network=zmq daf63168161f
 ``` 

Using the ID copied from the previous step. The container will appear to start and hang, but it's just waiting for the server to start.

To run the server container directly navigate to the zmq-hello-world-server-node and run:

```
docker build .
```

When this completes you will see a message: `Successfully built 0f46b3a6544c`. Note that the ID at the end of the message will be different. Copy the ID and enter the command: 

```
docker run -it --network=zmq --net-alias=zmq-hello-world-server-cpp 0f46b3a6544c
```

Using the ID copied from the previous step. The containers will now start talking to each other as the client sends through 10 messages before completing.

## Executing the docker containers from CLion on OSX

Assuming you are using the latest native version of Docker, run the following command to pipe the output of Docker to a URL that CLion will understand:

`sudo socat TCP-LISTEN:777,reuseaddr,fork,bind=localhost UNIX-CONNECT:/var/run/docker.sock`

Then follow the normal steps documented [here](https://www.jetbrains.com/help/clion/2016.3/docker-integration.html) to setup Docker to run your project. When you need to enter a URL for the Docker API, use `tcp://localhost:777`.