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
FROM wso2/wso2am:2.6.0
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
ARG WSO2_SERVER=wso2apim
ARG WSO2_SERVER_VERSION=2.6.0
ARG WSO2_SERVER_PACK=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER_PACK}
# set WSO2 EULA
ARG MOTD="\
Welcome to WSO2 Docker resources.\n\
------------------------------------ \n\
The Docker container contains the WSO2 product with its latest updates, which are under the End User License Agreement (EULA) 2.0.\n\
\n\
Read more about EULA 2.0 (https://wso2.com/licenses/wso2-update/2.0).\n"

# copy init script to user home
COPY --chown=wso2carbon:wso2 init.sh ${USER_HOME}/
# edit offset of WSO2 EI Server
COPY --chown=wso2carbon:wso2 ${FILES}/carbon.xml ${WSO2_SERVER_HOME}/repository/conf/carbon.xml

# set the user and work directory
USER ${USER_ID}
WORKDIR ${USER_HOME}

# set environment variables
ENV JAVA_HOME=${JAVA_HOME} \
    PATH=$JAVA_HOME/bin:$PATH \
    WSO2_SERVER_HOME=${WSO2_SERVER_HOME} \
    WORKING_DIRECTORY=${USER_HOME}

# expose ports
EXPOSE 8280 8253 9773 9453 9109 5682 9721 9621 7721 7621 10407

# initiate container and start WSO2 Carbon server
ENTRYPOINT ${WORKING_DIRECTORY}/init.sh
