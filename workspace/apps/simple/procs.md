⊕ [Quick Start - Spark 2.4.0 Documentation](https://spark.apache.org/docs/latest/quick-start.html)

## start
```sh
$ vi build.sbt
$ mkdir -p src/main/scala
$ vi ./src/main/scala/SimpleApp.scala
$ sbt package

# Use spark-submit to run your application
$ $SPARK_HOME/bin/spark-submit \
  --class "SimpleApp" \
  --master local[4] \
  target/scala-2.11/simple-project_2.11-1.0.jar
```
```scala
name := "Simple Project"

version := "1.0"

scalaVersion := "2.11.12"

libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.4.0"
```

## start with python
```sh
$SPARK_HOME/bin/spark-submit pi.py
```

## in intellij
⊕ [scala - Spark - Error "A master URL must be set in your configuration" when submitting an app - Stack Overflow](https://stackoverflow.com/questions/38008330/spark-error-a-master-url-must-be-set-in-your-configuration-when-submitting-a)

+ 如果不是用submit提交任务, 则需要加入如下的config(spark.master):

```scala
    val spark = SparkSession
      .builder
      .appName("StructuredNetworkWordCount")
      .config("spark.master", "local")
      .getOrCreate()
```
This is because setting spark.master=local means that you are NOT running in cluster mode.

Instead, for a production app, within your main function (or in functions called by your main function), you should simply use:

```scala
SparkSession
.builder()
.appName("Java Spark SQL basic example")
.getOrCreate();
```
This will use the configurations specified on the command line/in config files.

or 

```scala
SparkConf sparkConf = new SparkConf().setAppName("SOME APP NAME").setMaster("local[2]").set("spark.executor.memory","1g");
```

