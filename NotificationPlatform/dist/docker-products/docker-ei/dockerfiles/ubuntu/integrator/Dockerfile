# ------------------------------------------------------------------------
#
# Copyright 2018 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------


# set to product base image
FROM wso2/wso2ei-integrator:6.4.0

# set user configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# set dependant files directory
ARG FILES=./files

# set wso2 product configurations
ARG WSO2_SERVER=wso2ei
ARG WSO2_SERVER_VERSION=6.4.0
ARG WSO2_SERVER_PACK=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER_PACK}

# set the user and work directory
USER ${USER}
WORKDIR ${USER_HOME}

# set environment variables
ENV JAVA_HOME=${JAVA_HOME} \
    PATH=$JAVA_HOME/bin:$PATH \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME} \
    WORKING_DIRECTORY=${USER_HOME}

# set WSO2 EULA
ARG MOTD="\n\
Welcome to WSO2 Docker resources.\n\
------------------------------------ \n\
This Docker container comprises of a WSO2 product, running with its latest GA release \n\
which is under the Apache License, Version 2.0. \n\
Read more about Apache License, Version 2.0 here @ http://www.apache.org/licenses/LICENSE-2.0.\n"

# copy entrypoint bash script to user home and external libraries to product home
COPY --chown=wso2carbon:wso2 init.sh ${WORKING_DIRECTORY}/
# copy addtional libs to user's home directory
COPY --chown=wso2carbon:wso2 ${FILES}/kafka-clients-1.0.0.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/kafka_2.12-1.0.0.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/metrics-core-2.2.0.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/mysql-connector-java-8.0.12.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/scala-library-2.12.3.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/zkclient-0.10.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/zookeeper-3.4.10.jar ${WSO2_SERVER_HOME}/lib/
COPY --chown=wso2carbon:wso2 ${FILES}/org.apache.synapse.kafka.poll-1.0.5.jar ${WSO2_SERVER_HOME}/dropins/
COPY --chown=wso2carbon:wso2 ${FILES}/EPIC_Healthcare_Alert_ProjectCompositeApplication_1.0.0.car ${WSO2_SERVER_HOME}/repository/deployment/server/carbonapps/

# create directory tree for latest zookeeper support
RUN mkdir -p ${WSO2_SERVER_HOME}/repository/conf
RUN mkdir -p ${WSO2_SERVER_HOME}/repository/conf/identity
# copy jass.conf into above directory
COPY --chown=wso2carbon:wso2 ${FILES}/jaas.conf ${WSO2_SERVER_HOME}/repository/conf/identity/
# edit offset of WSO2 EI Server
COPY --chown=wso2carbon:wso2 ${FILES}/carbon.xml ${WSO2_SERVER_HOME}/conf/
# Add json+fhir message formatters and message Builders
COPY --chown=wso2carbon:wso2 ${FILES}/axis2.xml ${WSO2_SERVER_HOME}/conf/axis2/

# set temporary location for shared artifacts
RUN mkdir -p ${WORKING_DIRECTORY}/wso2-tmp/ && \
    cp -r ${WSO2_SERVER_HOME}/repository/deployment/server/ ${WORKING_DIRECTORY}/wso2-tmp/server/

# expose integrator ports
EXPOSE 8283 8246 9446 4103

# set entrypoint to init script
ENTRYPOINT ["/home/wso2carbon/init.sh"]
