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
FLUME_HOME=${FLUME_HOME:-/opt/flume}
echo "FLUME_HOME=${FLUME_HOME}"

FLUME_CONF_DIR=${FLUME_CONF_DIR:-${FLUME_HOME}/conf}
echo "FLUME_CONF_DIR=${FLUME_CONF_DIR}"

FLUME_COMMAND=${FLUME_COMMAND:-agent}
echo "FLUME_COMMAND=${FLUME_COMMAND}"

FLUME_OPT_CONF=${FLUME_OPT_CONF:-${FLUME_CONF_DIR}}
echo "FLUME_OPT_CONF=${FLUME_OPT_CONF}"

FLUME_OPT_CLASSPATH=${FLUME_OPT_CLASSPATH:-""}
echo "FLUME_OPT_CLASSPATH=${FLUME_OPT_CLASSPATH}"

FLUME_OPT_PLUGINS_PATH=${FLUME_OPT_PLUGINS_PATH:-$FLUME_HOME/plugins.d}
echo "FLUME_OPT_PLUGINS_PATH=${FLUME_OPT_PLUGINS_PATH}"

FLUME_AGENT_NAME=${FLUME_AGENT_NAME:-agent}
echo "FLUME_AGENT_NAME=${FLUME_AGENT_NAME}"

FLUME_AGENT_CONF_FILE=${FLUME_AGENT_CONF_FILE:-${FLUME_CONF_DIR}/flume-conf.properties}
echo "FLUME_AGENT_CONF_FILE=${FLUME_AGENT_CONF_FILE}"

FLUME_AGENT_ZK_CONN_STRING=${FLUME_AGENT_ZK_CONN_STRING:-""}
echo "FLUME_AGENT_ZK_CONN_STRING=${FLUME_AGENT_ZK_CONN_STRING}"

FLUME_AGENT_ZK_BASE_PATH=${FLUME_AGENT_ZK_BASE_PATH:-/flume}
echo "FLUME_AGENT_ZK_BASE_PATH=${FLUME_AGENT_ZK_BASE_PATH}"

FLUME_AGENT_NO_RELOAD_CONF==${FLUME_AGENT_NO_RELOAD_CONF:-false}
echo "FLUME_AGENT_NO_RELOAD_CONF=${FLUME_AGENT_NO_RELOAD_CONF}"

FLUME_PID_FILE=${FLUME_PID_FILE:-${FLUME_HOME}/flume.pid}
echo "FLUME_PID_FILE=${FLUME_PID_FILE}"

FLUME_CLASSPATH=${FLUME_CLASSPATH:-""}
echo "FLUME_CLASSPATH=${FLUME_CLASSPATH}"

ZOOKEEPER_CLI_PREFIX=${ZOOKEEPER_CLI_PREFIX:-/opt/zookeeper-cli}
echo "ZOOKEEPER_CLI_PREFIX=${ZOOKEEPER_CLI_PREFIX}"

# Start function
function start() {
  # Create plugins dir.
  if [ ! -e ${FLUME_OPT_PLUGINS_PATH} ]; then
    mkdir -p ${FLUME_OPT_PLUGINS_PATH}
  fi

  FLUME_OPTS="${FLUME_COMMAND}"
  if [ -n ${FLUME_OPT_CONF} ]; then
    FLUME_OPTS="${FLUME_OPTS} --conf ${FLUME_OPT_CONF}"
  fi
  if [ -n ${FLUME_OPT_CLASSPATH} ]; then
    FLUME_OPTS="${FLUME_OPTS} --classpath ${FLUME_OPT_CLASSPATH}"
  fi
  if [ -n ${FLUME_OPT_PLUGINS_PATH} ]; then
    FLUME_OPTS="${FLUME_OPTS} --plugins-path ${FLUME_OPT_PLUGINS_PATH}"
  fi
  if [ -n ${FLUME_AGENT_NAME} ]; then
    FLUME_OPTS="${FLUME_OPTS} --name ${FLUME_AGENT_NAME}"
  fi

  if [ -n "${FLUME_AGENT_ZK_CONN_STRING}" ]; then
    echo "Starting flume with ZooKeeper"
  
    # Upload flume-conf.properties to ZooKeeper.
    ${ZOOKEEPER_CLI_PREFIX}/bin/zkNiCli.sh -s ${FLUME_AGENT_ZK_CONN_STRING} create -p "${FLUME_AGENT_ZK_BASE_PATH}/${FLUME_AGENT_NAME}" "$(cat ${FLUME_HOME}/conf/flume-conf.properties)"
 
    FLUME_OPTS="${FLUME_OPTS} --zkConnString ${FLUME_AGENT_ZK_CONN_STRING}"
    FLUME_OPTS="${FLUME_OPTS} --zkBasePath ${FLUME_AGENT_ZK_BASE_PATH}"

    # Start Flume.
    ${FLUME_HOME}/bin/flume-ng ${FLUME_OPTS} -Dflume.root.logger=INFO,console &
  else
    echo "Starting flume"

    FLUME_OPTS="${FLUME_OPTS} --conf-file ${FLUME_AGENT_CONF_FILE}"

    # Start Flume.
    ${FLUME_HOME}/bin/flume-ng ${FLUME_OPTS} -Dflume.root.logger=INFO,console &
  fi
  echo -n $! > ${FLUME_PID_FILE}
}

trap "docker-stop.sh; exit 1" TERM KILL INT QUIT

# Start
start

# Start infinitive loop
while true
do
 sleep 1
done
