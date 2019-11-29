# procs-kafka.md
⊕ [kafka-python · PyPI](https://pypi.org/project/kafka-python/)
⊕ [Processing Data in Apache Kafka with Structured Streaming](https://databricks.com/blog/2017/04/26/processing-data-in-apache-kafka-with-structured-streaming-in-apache-spark-2-2.html)
⊕ [结构化流+ Kafka集成指南（Kafka代理版本0.10.0或更高版本） - Spark 2.4.0文档](https://spark.apache.org/docs/latest/structured-streaming-kafka-integration.html)

## install
```sh
pip install kafka-python

$ brew services start zookeeper
$ brew services start kafka
```

## kafka cli
```sh

$ kafka-topics --list --zookeeper $HOST_IP:2181
$ kafka-topics --delete --zookeeper $HOST_IP:2181 --topic topic1
# $ kafka-topics --create --zookeeper $HOST_IP:2181 --replication-factor 3 --partitions 2 --topic topic1
$ kafka-topics --create --zookeeper $HOST_IP:2181 --replication-factor 1 --partitions 1 --topic topic1

$ kafka-console-consumer --bootstrap-server $HOST_IP:9092 --topic topic1 --from-beginning
$ kafka-console-producer --broker-list $HOST_IP:9092 --topic topic1
```

## messages
```python
from kafka import KafkaConsumer
consumer = KafkaConsumer('my_favorite_topic')
for msg in consumer:
    print (msg)

# join a consumer group for dynamic partition assignment and offset commits
from kafka import KafkaConsumer
consumer = KafkaConsumer('my_favorite_topic', group_id='my_favorite_group')
for msg in consumer:
    print (msg)    
```

## json
```python
# Serialize json messages
import json
producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'))
producer.send('fizzbuzz', {'foo': 'bar'})
```

## structured-streaming-kafka-integration
⊕ [结构化流+ Kafka集成指南（Kafka代理版本0.10.0或更高版本） - Spark 2.4.0文档](https://spark.apache.org/docs/latest/structured-streaming-kafka-integration.html)
⊕ [scala - How to use from_json with Kafka connect 0.10 and Spark Structured Streaming? - Stack Overflow](https://stackoverflow.com/questions/42506801/how-to-use-from-json-with-kafka-connect-0-10-and-spark-structured-streaming)

```scala
import spark.implicits._

val ds1 = spark
          .readStream
          .format("kafka")
          .option("kafka.bootstrap.servers", IP + ":9092")
          .option("zookeeper.connect", IP + ":2181")
          .option("subscribe", TOPIC)
          .option("startingOffsets", "earliest")
          .option("max.poll.records", 10)
          .option("failOnDataLoss", false)
          .load()

// First you need to define the schema for your JSON message. For example

val schema = new StructType()
  .add($"id".string)
  .add($"name".string)

// Now you can use this schema in from_json method like below.

val df = ds1.select($"value" cast "string" as "json")
            .select(from_json($"json", schema) as "data")
            .select("data.*")
```
if you have compiler warning "value $ is not a member..." Please don't forget about import spark.implicits._ 

```scala
// Same query as staticInputDF
val streamingCountsDF = 
  df
    .groupBy($"action", window($"time", "1 hour"))
    .count()
```

## sink to kafka
prepare: create a topic events-out

```scala
println(streamingCountsDF.isStreaming)
println(streamingCountsDF.schema)

import java.util.UUID
import org.apache.spark.sql.functions._
import spark.implicits._

val checkpointLocation = "/tmp/temporary-" + UUID.randomUUID.toString
// Write key-value data from a DataFrame to a specific Kafka topic specified in an option
val ds = streamingCountsDF
  // .selectExpr("CAST(action AS STRING)", "CAST(count AS STRING)")
  .select(to_json(struct($"action", $"count", $"window.end")).alias("value"))
  .writeStream
  .format("kafka")
  .option("kafka.bootstrap.servers", IP + ":9092")
  .option("topic", "events-out")
  .option("checkpointLocation", checkpointLocation)
  .outputMode("complete")
  .start()
```
```sh
$ listen-all events-out
{"action":"Close","count":1,"end":"2016-07-26T12:00:00.000+08:00"}
{"action":"Open","count":5,"end":"2016-07-26T12:00:00.000+08:00"}
{"action":"Open","count":179,"end":"2016-07-26T11:00:00.000+08:00"}
{"action":"Close","count":11,"end":"2016-07-26T11:00:00.000+08:00"}
```

+ 关于select的格式:
    ⊕ [scala - Querying Spark SQL DataFrame with complex types - Stack Overflow](https://stackoverflow.com/questions/28332494/querying-spark-sql-dataframe-with-complex-types)

```scala
df.select($"an_array".getItem(1)).show
df.selectExpr("transform(an_array, x -> x + 1) an_array_inc").show
df.selectExpr("filter(an_array, x -> x % 2 == 0) an_array_even").show
df.selectExpr("aggregate(an_array, 0, (acc, x) -> acc + x, acc -> acc) an_array_sum").show
df.select(array_max($"an_array")).show
df.select($"a_map".getField("foo")).show
df.select($"a_map.foo").show

val get_field = udf((kvs: Map[String, String], k: String) => kvs.get(k))
df.select(get_field($"a_map", lit("foo"))).show
```

+ kafka sink test-suite:
    ⊕ [spark/KafkaSinkSuite.scala at master · apache/spark](https://github.com/apache/spark/blob/master/external/kafka-0-10-sql/src/test/scala/org/apache/spark/sql/kafka010/KafkaSinkSuite.scala)

+ 关于异常: org.apache.spark.sql.AnalysisException: Required attribute 'value' not found;
    ⊕ [scala - Error when Spark 2.2.0 standalone mode write Dataframe to local single-node Kafka - Stack Overflow](https://stackoverflow.com/questions/46454014/error-when-spark-2-2-0-standalone-mode-write-dataframe-to-local-single-node-kafk)

    * The Dataset to be written has to have at least value column (and optionally key and topic) 

```scala
import org.apache.spark.sql.functions._

res2.select(to_json(struct($"battery_level", $"c02_level")).alias("value"))
  .writeStream
  ...
```

+ 关于startingOffsets:
    ⊕ [Structured Streaming + Kafka Integration Guide (Kafka broker version 0.10.0 or higher) - Spark 2.2.0 Documentation](https://spark.apache.org/docs/2.2.0/structured-streaming-kafka-integration.html)

    startingOffsets "earliest", "latest" (streaming only), or json string """ {"topicA":{"0":23,"1":-1},"topicB":{"0":-2}} """  

    +default: "latest" for streaming, "earliest" for batch

    The start point when a query is started, either "earliest" which is from the earliest offsets, "latest" which is just from the latest offsets, or a json string specifying a starting offset for each TopicPartition. In the json, -2 as an offset can be used to refer to earliest, -1 to latest. Note: For batch queries, latest (either implicitly or by using -1 in json) is not allowed. For streaming queries, this only applies when a new query is started, and that resuming will always pick up from where the query left off. Newly discovered partitions during a query will start at earliest.
