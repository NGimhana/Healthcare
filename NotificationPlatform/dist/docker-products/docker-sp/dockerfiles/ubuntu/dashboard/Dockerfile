# ------------------------------------------------------------------------
#
# Copyright 2017 WSO2, Inc. (http://wso2.com)
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

# set to latest Ubuntu LTS
FROM ubuntu:18.04
FROM wso2/wso2sp-dashboard:4.3.0
MAINTAINER WSO2 Docker Maintainers "dev@wso2.org"

# set user configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}
# set dependant files directory
ARG FILES=./files
# set jdk configurations
ARG JDK=jdk1.8.0*
ARG JAVA_HOME=${USER_HOME}/java
# set wso2 product configurations
ARG WSO2_SERVER=wso2sp
ARG WSO2_SERVER_VERSION=4.3.0
ARG WSO2_SERVER_PACK=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER_PACK}

# set the user and work directory
USER ${USER_ID}
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

# copy addtional libs to user's home directory
COPY --chown=wso2carbon:wso2 ${FILES}/libs ${WSO2_SERVER_HOME}/lib/
# copy sp deployment ymal
COPY --chown=wso2carbon:wso2 ${FILES}/deployment.yaml ${WSO2_SERVER_HOME}/conf/dashboard/

# Copy Business Rule Template to SP dashboard
COPY --chown=wso2carbon:wso2 ${FILES}/sp_templates/epic_healthcare_alert.json ${WSO2_SERVER_HOME}/wso2/dashboard/resources/businessRules/templates/

# copy entrypoint bash script to user home
COPY --chown=wso2carbon:wso2 init.sh ${WORKING_DIRECTORY}/

# expose ports
EXPOSE 9713 9643 9613 7713 7613

ENTRYPOINT ["/home/wso2carbon/init.sh"]
