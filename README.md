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

### Standalone example

1. Start

```
$ docker run -d --name flume mosuka/docker-flume:latest
```

1. Stop

```
$ docker stop flume; docker rm flume
flume
flume
```