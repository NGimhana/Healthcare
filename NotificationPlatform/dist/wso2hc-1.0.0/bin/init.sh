#!/bin/bash

#Import Properties File
. ./startup.properties

echo "Starting WSO2 Healthcare Alert Platform...";

nohup ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
sleep 20s
echo "[ZOOKEEPER] Server Started"
	
nohup ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties & 
sleep 20s
echo "[KAFKA] Server Started"

echo -e "Starting SP worker .."
#Start Stream Processor worker
gnome-terminal -x sh ${SP_HOME}/bin/worker.sh & sleep 10s
#nohup sh sp_worker & sleep 10s

echo -e "Starting Stream Processor Dashboard .." 
#Start Stream Processor Template Dashboard
gnome-terminal -x sh ${SP_HOME}/bin/dashboard.sh & sleep 5s
#nohup sh sp_dashboard & sleep 10s

echo -e "Starting WSO2 Enterprice Integrator Server .."
#Start EI Server
gnome-terminal -x sh ${EI_HOME}/bin/integrator.sh & sleep 5s
#nohup sh integrator & sleep 10s

echo -e "Starting API Manager Server .."
#Start APIM server
gnome-terminal -x sh ${APIM_HOME}/bin/wso2server.sh & sleep 20s
#nohup sh apim & sleep 20s 
  
echo -e "Servers are Started"


