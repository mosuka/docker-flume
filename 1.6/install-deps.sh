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
FLUME_PLUGINS_DIR=${FLUME_PLUGINS_DIR:-${FLUME_HOME}/plugins.d}
FLUME_RESOURCES_DIR=${FLUME_PLUGINS_DIR:-${FLUME_HOME}/resources}

mkdir -p ${FLUME_PLUGINS_DIR}
mkdir -p ${FLUME_RESOURCES_DIR}

# MorphlineSolrSink dependencies.
FLUME_SOLR_SINK=solrSink
FLUME_SOLR_SINK_PLUGINS_DIR=${FLUME_PLUGINS_DIR}/${FLUME_SOLR_SINK}
mkdir -p ${FLUME_SOLR_SINK_PLUGINS_DIR}

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-core-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-core/4.10.4/lucene-core-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-common-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-common/4.10.4/lucene-analyzers-common-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-icu-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-icu/4.10.4/lucene-analyzers-icu-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-kuromoji-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-kuromoji/4.10.4/lucene-analyzers-kuromoji-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-morfologik-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-morfologik/4.10.4/lucene-analyzers-morfologik-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-phonetic-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-phonetic/4.10.4/lucene-analyzers-phonetic-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-smartcn-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-smartcn/4.10.4/lucene-analyzers-smartcn-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-stempel-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-stempel/4.10.4/lucene-analyzers-stempel-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-analyzers-uima-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-analyzers-uima/4.10.4/lucene-analyzers-uima-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-benchmark-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-benchmark/4.10.4/lucene-benchmark-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-classification-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-classification/4.10.4/lucene-classification-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-codecs-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-codecs/4.10.4/lucene-codecs-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-demo-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-demo/4.10.4/lucene-demo-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-expressions-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-expressions/4.10.4/lucene-expressions-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-facet-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-facet/4.10.4/lucene-facet-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-grouping-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-grouping/4.10.4/lucene-grouping-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-highlighter-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-highlighter/4.10.4/lucene-highlighter-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-join-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-join/4.10.4/lucene-join-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-memory-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-memory/4.10.4/lucene-memory-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-misc-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-misc/4.10.4/lucene-misc-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-queries-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-queries/4.10.4/lucene-queries-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-queryparser-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-queryparser/4.10.4/lucene-queryparser-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-replicator-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-replicator/4.10.4/lucene-replicator-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-sandbox-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-sandbox/4.10.4/lucene-sandbox-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-spatial-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-spatial/4.10.4/lucene-spatial-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-suggest-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-suggest/4.10.4/lucene-suggest-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/lucene-test-framework-4.10.4.jar http://central.maven.org/maven2/org/apache/lucene/lucene-test-framework/4.10.4/lucene-test-framework-4.10.4.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-solrj-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-solrj/4.10.4/solr-solrj-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-analysis-extras-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-analysis-extras/4.10.4/solr-analysis-extras-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-cell-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-cell/4.10.4/solr-cell-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-clustering-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-clustering/4.10.4/solr-clustering-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-core-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-core/4.10.4/solr-core-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-dataimporthandler-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-dataimporthandler/4.10.4/solr-dataimporthandler-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-dataimporthandler-extras-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-dataimporthandler-extras/4.10.4/solr-dataimporthandler-extras-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-langid-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-langid/4.10.4/solr-langid-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-map-reduce-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-map-reduce/4.10.4/solr-map-reduce-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-morphlines-cell-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-morphlines-cell/4.10.4/solr-morphlines-cell-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-morphlines-core-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-morphlines-core/4.10.4/solr-morphlines-core-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-test-framework-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-test-framework/4.10.4/solr-test-framework-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-uima-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-uima/4.10.4/solr-uima-4.10.4.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/solr-velocity-4.10.4.jar http://central.maven.org/maven2/org/apache/solr/solr-velocity/4.10.4/solr-velocity-4.10.4.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/zookeeper-3.4.6.jar http://central.maven.org/maven2/org/apache/zookeeper/zookeeper/3.4.6/zookeeper-3.4.6.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/kite-morphlines-core-1.0.0.jar http://central.maven.org/maven2/org/kitesdk/kite-morphlines-core/1.0.0/kite-morphlines-core-1.0.0.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/kite-morphlines-json-1.0.0.jar http://central.maven.org/maven2/org/kitesdk/kite-morphlines-json/1.0.0/kite-morphlines-json-1.0.0.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/kite-morphlines-solr-core-1.0.0.jar http://central.maven.org/maven2/org/kitesdk/kite-morphlines-solr-core/1.0.0/kite-morphlines-solr-core-1.0.0.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/kite-morphlines-solr-cell-1.0.0.jar http://central.maven.org/maven2/org/kitesdk/kite-morphlines-solr-cell/1.0.0/kite-morphlines-solr-cell-1.0.0.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/kite-morphlines-maxmind-1.0.0.jar http://central.maven.org/maven2/org/kitesdk/kite-morphlines-maxmind/1.0.0/kite-morphlines-maxmind-1.0.0.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/metrics-core-3.0.2.jar http://central.maven.org/maven2/com/codahale/metrics/metrics-core/3.0.2/metrics-core-3.0.2.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/metrics-healthchecks-3.0.2.jar http://central.maven.org/maven2/com/codahale/metrics/metrics-healthchecks/3.0.2/metrics-healthchecks-3.0.2.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/config-1.0.2.jar http://central.maven.org/maven2/com/typesafe/config/1.0.2/config-1.0.2.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/noggit-0.5.jar http://central.maven.org/maven2/org/noggit/noggit/0.5/noggit-0.5.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/httpclient-4.3.1.jar http://central.maven.org/maven2/org/apache/httpcomponents/httpclient/4.3.1/httpclient-4.3.1.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/httpcore-4.3.1.jar http://central.maven.org/maven2/org/apache/httpcomponents/httpcore/4.3.1/httpcore-4.3.1.jar
curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/httpmime-4.3.1.jar http://central.maven.org/maven2/org/apache/httpcomponents/httpmime/4.3.1/httpmime-4.3.1.jar

curl -s -L -o ${FLUME_SOLR_SINK_PLUGINS_DIR}/lib/maxmind-db-1.0.0.jar http://central.maven.org/maven2/com/maxmind/db/maxmind-db/1.0.0/maxmind-db-1.0.0.jar

mkdir -p ${FLUME_RESOURCES_DIR}/grok-dictionaries
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/firewalls https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/firewalls
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/grok-patterns https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/grok-patterns
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/java https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/java
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/linux-syslog https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/linux-syslog
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/mcollective https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/mcollective
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/mcollective-patterns https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/mcollective-patterns
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/nagios https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/nagios
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/postgresql https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/postgresql
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/redis https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/redis
curl -L-o ${FLUME_RESOURCES_DIR}/grok-dictionaries/ruby https://raw.githubusercontent.com/kite-sdk/kite/master/kite-morphlines/kite-morphlines-core/src/test/resources/grok-dictionaries/ruby

mkdir -p ${FLUME_RESOURCES_DIR}/geoip
curl -s -L -o ${FLUME_RESOURCES_DIR}/geoip/GeoLite2-City.mmdb.gz http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
gzip -d -c ${FLUME_RESOURCES_DIR}/geoip/GeoLite2-City.mmdb.gz > ${FLUME_RESOURCES_DIR}/geoip/GeoLite2-City.mmdb
rm ${FLUME_RESOURCES_DIR}/geoip/GeoLite2-City.mmdb.gz
