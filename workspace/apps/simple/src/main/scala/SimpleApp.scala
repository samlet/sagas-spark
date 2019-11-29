/* SimpleApp.scala */

import org.apache.spark.sql.SparkSession

object SimpleApp {
  def main(args: Array[String]) {
    // var sparkHome = sys.env("SPARK_HOME")
    var sparkHome = "/usr/local/bin/spark-2.4.0"

    val logFile = s"$sparkHome/README.md" // Should be some file on your system

    // SPARK_OPTS='--master=local[4]'
    val spark = SparkSession.builder.appName("Simple Application")
      .config("spark.master", "local")
      .getOrCreate()
    val logData = spark.read.textFile(logFile).cache()
    val numAs = logData.filter(line => line.contains("a")).count()
    val numBs = logData.filter(line => line.contains("b")).count()
    println(s"Lines with a: $numAs, Lines with b: $numBs")
    spark.stop()
  }
}
