#!/bin/bash
# prepare: sbt package
$SPARK_HOME/bin/spark-submit \
  --class "com.sagas.kafka.StreamingCounter" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
  target/scala-2.11/summarizer-project_2.11-1.0.jar

