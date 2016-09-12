# docker-flume

This is a Docker image for Flume.

## What is Flume?

[Apache Flume](https://flume.apache.org) is a distributed, reliable, and available service for efficiently collecting, aggregating, and moving large amounts of log data. It has a simple and flexible architecture based on streaming data flows. It is robust and fault tolerant with tunable reliability mechanisms and many failover and recovery mechanisms. The system is centrally managed and allows for intelligent dynamic management. It uses a simple extensible data model that allows for online analytic application.

Learn more about Flume on the [Flume Documentation](https://flume.apache.org/documentation.html).

## How to build this Docker image

```
$ git clone git@github.com:mosuka/docker-flume.git ${HOME}/git/docker-flume
$ docker build -t mosuka/docker-flume:latest ${HOME}/git/docker-flume
```

## How to pull this Docker image

```
$ docker pull mosuka/docker-flume:latest
```

## How to use this Docker image

### Standalone Flume

#### 1. Start

```
$ docker run -d --name flume mosuka/docker-flume:latest
b1e8a875d7ed860cd548305a040ec12e99eb7cb5c92b6b1865cbaf592aa0927e

$ FLUME_CONTAINER_IP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' flume)
$ echo ${FLUME_CONTAINER_IP}
172.17.0.2
```

#### 2. Stop

```
$ docker stop flume; docker rm flume
flume
flume
```

### Start Flume cluster with ZooKeeper

#### 1. Start Zookeeper

Run ZooKeeper. See following URL:

- Source: [https://github.com/mosuka/docker-zookeeper](https://github.com/mosuka/docker-zookeeper)
- Docker Image: [https://hub.docker.com/r/mosuka/docker-zookeeper/](https://hub.docker.com/r/mosuka/docker-zookeeper/)

#### 2. Start

```
$ docker run -d --name flume -e FLUME_AGENT_ZK_CONN_STRING=${ZOOKEEPER_CONTAINER_IP}:2181 -e FLUME_AGENT_ZK_BASE_PATH=/flume mosuka/docker-flume:latest
b1e8a875d7ed860cd548305a040ec12e99eb7cb5c92b6b1865cbaf592aa0927e

$ FLUME_CONTAINER_IP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' flume)
$ echo ${FLUME_CONTAINER_IP}
172.17.0.3
```

#### 3. Stop

```
$ docker stop flume; docker rm flume
flume
flume
```
