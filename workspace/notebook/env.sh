#!/bin/bash
alias list-topic='kafka-topics --list --zookeeper $HOST_IP:2181'
alias create-topic='kafka-topics --create --zookeeper $HOST_IP:2181 --replication-factor 1 --partitions 1 --topic'
alias delete-topic='kafka-topics --delete --zookeeper $HOST_IP:2181 --topic '
alias listen-all='kafka-console-consumer --bootstrap-server $HOST_IP:9092 --from-beginning --topic'
alias listen-topic='kafka-console-consumer --bootstrap-server $HOST_IP:9092 --topic'
alias send-topic='kafka-console-producer --broker-list $HOST_9092 --topic'




