# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# If this scripted is run out of /usr/bin or some other system bin directory
# it should be linked to and not copied. Things like java jar files are found
# relative to the canonical path of this script.
#

FROM java:openjdk-6-jre
MAINTAINER Minoru Osuka "minoru.osuka@gmail.com"

ENV FLUME_GROUP flume
ENV FLUME_USER flume
ENV FLUME_UID 41414
ENV HOME=/home/${FLUME_USER}
ENV FLUME_VERSION 1.6.0
ENV ZOOKEEPER_VERSION 3.4.6
ENV FLUME_HOME ${HOME}/apache-flume-${FLUME_VERSION}-bin
ENV ZOOKEEPER_PREFIX ${HOME}/zookeeper-${ZOOKEEPER_VERSION}

RUN apt-get update && \
    apt-get install -y tar && \
    apt-get clean && \
    mkdir -p ${HOME} && \
    groupadd -r ${FLUME_GROUP} && \
    useradd -u ${FLUME_UID} -g ${FLUME_GROUP} -d ${HOME} ${FLUME_USER} && \
    curl -L -o ${HOME}/apache-flume-${FLUME_VERSION}-bin.tar.gz http://archive.apache.org/dist/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz && \
    tar -C ${HOME} -xf ${HOME}/apache-flume-${FLUME_VERSION}-bin.tar.gz && \
    rm ${HOME}/apache-flume-${FLUME_VERSION}-bin.tar.gz && \
    curl -L -o ${HOME}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz http://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    tar -C ${HOME} -xf ${HOME}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    rm ${HOME}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    chown -R ${FLUME_USER}:${FLUME_GROUP} ${HOME}

ADD docker-stop.sh /usr/local/bin/
ADD docker-stop.sh /usr/local/bin/

EXPOSE 41414

USER ${FLUME_USER}
WORKDIR ${HOME}

CMD ["/usr/local/bin/docker-run.sh"]
