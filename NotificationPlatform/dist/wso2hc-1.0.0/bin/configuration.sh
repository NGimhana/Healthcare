#!/bin/bash

#Import Properties File
. ./startup.properties

DB_SQL=$PWD/db/AlertDb.sql

db_configuration(){
	mysql -h ${DB_HOST} -u ${DB_USER} -p${DB_PASSWORD} < ${DB_SQL};
}

kafka_configuration(){

	
	nohup ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
	sleep 20s
	echo "[ZOOKEEPER] Server Started"
	
	nohup ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties & 
	sleep 20s
	echo "[KAFKA] Server Started"

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic hemoglobin-epic 
	echo "[TOPIC] 'hemoglobin-epic' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic Medication-order-epic 
	echo "[TOPIC] 'Medication-order-epic' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic cholesterol-epic
	echo "[TOPIC] 'cholesterol-epic' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic glucose-epic 
	echo "[TOPIC] 'glucose-epic' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic potasium-in-blood-epic
	echo "[TOPIC] 'potasium-in-blood-epic' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic bloodhemoglobin-epic-alert 
	echo "[TOPIC] 'bloodhemoglobin-epic-alert' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic medication-order-epic-alert
	echo "[TOPIC] 'medication-order-epic-alert' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic bloodglucose-epic-alert 
	echo "[TOPIC] 'bloodglucose-epic-alert' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic bloodpotasium-epic-alert 
	echo "[TOPIC] 'bloodpotasium-epic-alert' created"
	sleep 5s

	nohup ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic Bloodcholesterol-epic-alert
	echo "[TOPIC] 'Bloodcholesterol-epic-alert' created"
	sleep 5s

	#Kill Kafka 
	nohup ${KAFKA_HOME}/bin/kafka-server-stop.sh &
	sleep 5s
	echo "[KAFKA] Server Stopped"	

	#Kill zookeeper
	nohup ${KAFKA_HOME}/bin/zookeeper-server-stop.sh &
	sleep 5s
	echo "[ZOOKEEPER] Server Stopped"
}


ei_configuration(){

	#Copy Kafka Libs to EI/libs directory
	cp -a ../repository/components/kafka_libs/. ${EI_HOME}/lib;

	#Copy Mysql_connector to EI/libs directory
	cp -a ../repository/components/mysql_connector/. ${EI_HOME}/lib;

	#Copy Kafka_inbound poll lib to EI/dropins
	cp -a ../repository/components/kafka_inbound_libs/. ${EI_HOME}/dropins;

	#Create directory tree in EI_HOME
	mkdir -m 777 ${EI_HOME}/repository/conf;
	mkdir -m 777 ${EI_HOME}/repository/conf/identity;

	#Copy jaas.conf into above directory
	cp ../repository/conf/kafka_inbound/jaas.conf ${EI_HOME}/repository/conf/identity;

	#Edit offset of EI
	sed -i 's/<Offset>0<\/Offset>/<Offset>3<\/Offset>/g' ${EI_HOME}/conf/carbon.xml

	#Add json+fhir message formatters and message Builders
	cp -f ../repository/conf/axis2/axis2.xml ${EI_HOME}/conf/axis2/axis2.xml;


	#Copy CAR file to deployment server
	cp -a ../repository/deployment/server/. ${EI_HOME}/repository/deployment/server/carbonapps 

}

sp_configuration(){
		
	#Copy Kafka_inbound poll lib to EI/dropins
	cp -a ../repository/components/kafka_libs_sp/. ${SP_HOME}/lib;
		

	#copy sp deployment ymal 
	cp -f ../repository/conf/sp_businessrule/deployment.yaml ${SP_HOME}/conf/dashboard/deployment.yaml;

	#Copy Business Rule Template to SP dashboard
	cp -f ../repository/deployment/sp_templates/epic_healthcare_alert.json ${SP_HOME}/wso2/dashboard/resources/businessRules/templates;

}

apim_configuration(){

	#Edit offset of APIM
	sed -i 's/<Offset>0<\/Offset>/<Offset>10<\/Offset>/g' ${APIM_HOME}/repository/conf/carbon.xml
}

db_configuration;
kafka_configuration;
ei_configuration;
sp_configuration;
apim_configuration;

