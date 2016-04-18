#!/usr/bin/env bash

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

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container

# Set environment variables.
FLUME_PREFIX=${FLUME_PREFIX:-/opt/flume}
FLUME_COMMAND=${FLUME_COMMAND:-agent}
FLUME_CONF_DIR=${FLUME_CONF_DIR:-${FLUME_PREFIX}/conf}
FLUME_CLASSPATH=${FLUME_CLASSPATH:-""}
FLUME_AGENT_NAME=${FLUME_AGENT_NAME:-agent}
FLUME_CONF_FILE=${FLUME_CONF_FILE:-${FLUME_CONF_DIR}/flume-conf.properties}
FLUME_ZK_CONN_STRING=${FLUME_ZK_CONN_STRING:-localhost:2181}
FLUME_ZK_BASE_PATH=${FLUME_ZK_BASE_PATH:-/flume}

FLUME_PID_FILE=${FLUME_PID_FILE:-${FLUME_PREFIX}/flume.pid}

ZOOKEEPER_PREFIX=${ZOOKEEPER_PREFIX:-/opt/zookeeper}

# Show environment variables.
echo "FLUME_PREFIX=${FLUME_PREFIX}"
echo "FLUME_COMMAND=${FLUME_COMMAND}"
echo "FLUME_CONF_DIR=${FLUME_CONF_DIR}"
echo "FLUME_CLASSPATH=${FLUME_CLASSPATH}"
echo "FLUME_AGENT_NAME=${FLUME_AGENT_NAME}"
echo "FLUME_CONF_FILE=${FLUME_CONF_FILE}"

echo "ZOOKEEPER_PREFIX=${ZOOKEEPER_PREFIX}"

# Start function
function start() {
  if [ -n "${FLUME_ZK_CONN_STRING}" ]; then
    # Upload configs

    # Start Flume.
    ${FLUME_PREFIX}/bin/flume-ng ${FLUME_COMMAND} --zkConnString ${FLUME_ZK_CONN_STRING} --zkBasePath ${FLUME_ZK_BASE_PATH} -Dflume.root.logger=INFO,console &
  else
    # Start Flume.
    ${FLUME_PREFIX}/bin/flume-ng ${FLUME_COMMAND} --conf ${FLUME_CONF_DIR} --classpath ${FLUME_CLASSPATH} --name ${FLUME_AGENT_NAME} --conf-file ${FLUME_CONF_FILE} -Dflume.root.logger=INFO,console &
  fi
  echo -n $! > ${FLUME_PID_FILE}
}

trap "docker-stop.sh; exit 1" TERM KILL INT QUIT

# Start
start

# Start infinitive loop
while true
do
 tail -F /dev/null & wait ${!}
done
