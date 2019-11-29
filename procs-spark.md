# procs-spark.md
⊕ [apache/spark: Apache Spark](https://github.com/apache/spark)
⊕ [RDD Programming Guide - Spark 2.4.0 Documentation](https://spark.apache.org/docs/latest/rdd-programming-guide.html)

## faq
⊕ [scala - What does setMaster `local[*]` mean in spark? - Stack Overflow](https://stackoverflow.com/questions/32356143/what-does-setmaster-local-mean-in-spark)
    ./bin/spark-shell --master local[2]
    The --master option specifies the master URL for a distributed cluster, or local to run locally with one thread, or local[N] to run locally with N threads. You should start by using local for testing.

    And from here:
    local[*] Run Spark locally with as many worker threads as logical cores on your machine.

## 2.4
⊕ [Downloads | Apache Spark](https://spark.apache.org/downloads.html)
    groupId: org.apache.spark
    artifactId: spark-core_2.11
    version: 2.4.0

