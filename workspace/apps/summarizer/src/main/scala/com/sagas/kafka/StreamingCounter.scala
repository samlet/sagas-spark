package com.sagas.kafka
import org.apache.spark.sql.types._
import org.apache.spark.sql._
import org.apache.spark.sql.functions._

object StreamingCounter {
  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
      .appName("StructuredCounter")
      // .config("spark.master", "local")
      .getOrCreate()

    import spark.implicits._

    val schema = new StructType()
      .add($"time".timestamp)
      .add($"action".string)

    val IP="localhost"
    val TOPIC="events"
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

    // Now you can use this schema in from_json method like below.

    val df = ds1.select($"value" cast "string" as "json")
      .select(from_json($"json", schema) as "data")
      .select("data.*")

    // Same query as staticInputDF
    val streamingCountsDF =
      df
        .groupBy($"action", window($"time", "1 hour"))
        .count()
    spark.conf.set("spark.sql.shuffle.partitions", "1")  // keep the size of shuffles small

    import java.util.UUID
    import org.apache.spark.sql.functions._

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

    ds.awaitTermination()

  }
}
