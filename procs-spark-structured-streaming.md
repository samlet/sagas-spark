# procs-spark-structured-streaming.md
⊕ [[Structured streaming基础]--Structured Streaming 和Spark streaming的区别 - 余额不足 - CSDN博客](https://blog.csdn.net/high2011/article/details/80276617)
    引用Spark commiter(gatorsmile)的话：“从Spark-2.X版本后，Spark streaming就进入维护模式，Spark streaming是低阶API，给码农用的，各种坑；Structured streaming是给人设计的API，简单易用。

⊕ [结构化流编程指南 - Spark 2.4.0文档](https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html)

⊕ [FileStreamSource · The Internals of Spark Structured Streaming](https://jaceklaskowski.gitbooks.io/spark-structured-streaming/spark-sql-streaming-FileStreamSource.html)

⊕ [structured-streaming-scala.html - Databricks](https://docs.databricks.com/_static/notebooks/structured-streaming-scala.html)
⊕ [structured-streaming-python.html - Databricks](https://docs.databricks.com/_static/notebooks/structured-streaming-python.html)

⊕ [Table Streaming Reads and Writes — Databricks Documentation](https://docs.databricks.com/delta/delta-streaming.html)
⊕ [org.apache.spark.sql.types.StructField Scala Example](https://www.programcreek.com/scala/org.apache.spark.sql.types.StructField)

## read-stream
```scala
val spark: SparkSession = ...

// Read text from socket
val socketDF = spark
  .readStream
  .format("socket")
  .option("host", "localhost")
  .option("port", 9999)
  .load()

socketDF.isStreaming    // Returns True for DataFrames that have streaming sources

socketDF.printSchema

// Read all the csv files written atomically in a directory
val userSchema = new StructType().add("name", "string").add("age", "integer")
val csvDF = spark
  .readStream
  .option("sep", ";")
  .schema(userSchema)      // Specify schema of the csv files
  .csv("/path/to/directory")    // Equivalent to format("csv").load("/path/to/directory")
```

## Basic Operations - Selection, Projection, Aggregation
```scala
case class DeviceData(device: String, deviceType: String, signal: Double, time: DateTime)

val df: DataFrame = ... // streaming DataFrame with IOT device data with schema { device: string, deviceType: string, signal: double, time: string }
val ds: Dataset[DeviceData] = df.as[DeviceData]    // streaming Dataset with IOT device data

// Select the devices which have signal more than 10
df.select("device").where("signal > 10")      // using untyped APIs   
ds.filter(_.signal > 10).map(_.device)         // using typed APIs

// Running count of the number of updates for each device type
df.groupBy("deviceType").count()                          // using untyped API

// Running average signal for each device type
import org.apache.spark.sql.expressions.scalalang.typed
ds.groupByKey(_.deviceType).agg(typed.avg(_.signal))    // using typed API
```

## sql
You can also register a streaming DataFrame/Dataset as a temporary view and then apply SQL commands on it.

```scala
df.createOrReplaceTempView("updates")
spark.sql("select count(*) from updates")  // returns another streaming DF

// Note, you can identify whether a DataFrame/Dataset has streaming data or not by using df.isStreaming.

df.isStreaming
```

## window
+ https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html#window-operations-on-event-time

```scala
import spark.implicits._

val words = ... // streaming DataFrame of schema { timestamp: Timestamp, word: String }

// Group the data by window and word and compute the count of each group
val windowedCounts = words.groupBy(
  window($"timestamp", "10 minutes", "5 minutes"),
  $"word"
).count()
```

## kafka
⊕ [Processing Data in Apache Kafka with Structured Streaming](https://databricks.com/blog/2017/04/26/processing-data-in-apache-kafka-with-structured-streaming-in-apache-spark-2-2.html)




