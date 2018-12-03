#!/bin/bash

. ./startup.properties
	
echo -e "[WSO2 SP WORKER]Stopping WSO2 Stream Processor worker Server .."
nohup sh ${SP_HOME}/bin/worker.sh --stop > /dev/null 2>&1 &
sleep 5s

echo -e "[WSO2 SP DASHBOARD]Stopping WSO2 Stream Processor Dashboard .."
nohup sh ${SP_HOME}/bin/dashboard.sh --stop > /dev/null 2>&1 &
sleep 5s

echo -e "[WSO2 EI]Stopping WSO2 Enterprise Integrator Server .."
nohup sh ${EI_HOME}/bin/integrator.sh --stop > /dev/null 2>&1 &
sleep 5s

echo -e "[WSO2 APIM]Stopping WSO2 API Manager Server .."
nohup sh ${APIM_HOME}/bin/wso2server.sh --stop > /dev/null 2>&1 &
sleep 5s

#Kill Kafka 
nohup ${KAFKA_HOME}/bin/kafka-server-stop.sh &
sleep 5s
echo "[KAFKA] Stopping Server .."	

#Kill Kafka
nohup ${KAFKA_HOME}/bin/zookeeper-server-stop.sh &
sleep 5s
echo "[ZOOKEEPER] Stopping Server .."

echo -e "Servers are stopped";

echo "WSO2 Healthcare Notification Platform Stopped !!"
